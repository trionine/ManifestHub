// =============================================================
// faq.js — FAQ Accordion Loader & Data Store
// =============================================================
// Reads and manages FAQ items from Supabase, storage, or window.FAQ_DATA
// and renders an interactive accordion in the #faqContainer element.
// =============================================================

const FAQ_STORAGE_KEY = "MH_CUSTOM_FAQS";

/**
 * Retrieves the current active list of FAQ items.
 * Checks localStorage first, falls back to static window.FAQ_DATA.
 */
window.MH_getFAQs = function () {
  try {
    const raw = localStorage.getItem(FAQ_STORAGE_KEY);
    if (raw) {
      const parsed = JSON.parse(raw);
      if (Array.isArray(parsed) && parsed.length > 0) {
        return parsed;
      }
    }
  } catch (e) {
    console.warn("Could not parse saved FAQs:", e);
  }
  return window.FAQ_DATA || [];
};

/**
 * Persists an updated array of FAQ items to storage.
 */
window.MH_saveFAQs = function (faqs) {
  try {
    localStorage.setItem(FAQ_STORAGE_KEY, JSON.stringify(faqs));
    return true;
  } catch (e) {
    console.error("Failed to save FAQs:", e);
    return false;
  }
};

/**
 * Resets FAQ items back to default window.FAQ_DATA list.
 */
window.MH_resetFAQs = function () {
  try {
    localStorage.removeItem(FAQ_STORAGE_KEY);
  } catch (e) {
    console.error("Failed to reset FAQs:", e);
  }
  return window.FAQ_DATA || [];
};

/**
 * Helper to render the accordion markup from an array of FAQ items.
 */
function renderFaqAccordion(faqs, container) {
  container.innerHTML = "";
  // Filter out any entries that are marked inactive or expired
  const activeFaqs = (faqs || []).filter((f) => {
    if (f.is_active === false) return false;
    if (f.expires_at && new Date(f.expires_at) <= new Date()) return false;
    return true;
  });

  if (activeFaqs.length === 0) {
    container.innerHTML =
      '<div class="text-github-muted text-center py-4">No FAQ entries available.</div>';
    return;
  }

  activeFaqs.forEach((faq) => {
    const item = document.createElement("div");
    item.className = "faq-item";
    item.innerHTML = `
      <div class="faq-question">
        <span>${window.escapeHtml(faq.question)}</span>
        <i class="fas fa-chevron-down text-github-muted transition-transform"></i>
      </div>
      <div class="faq-answer">${faq.answer}</div>
    `;
    const questionDiv = item.querySelector(".faq-question");
    const answerDiv = item.querySelector(".faq-answer");
    const icon = item.querySelector("i");

    questionDiv.addEventListener("click", () => {
      const isOpen = answerDiv.classList.contains("open");
      // Close all other open ones (accordion behavior)
      document.querySelectorAll(".faq-answer.open").forEach((el) => {
        if (el !== answerDiv) {
          el.classList.remove("open");
          const otherIcon = el.previousElementSibling?.querySelector("i");
          if (otherIcon) otherIcon.style.transform = "rotate(0deg)";
        }
      });

      if (isOpen) {
        answerDiv.classList.remove("open");
        icon.style.transform = "rotate(0deg)";
      } else {
        answerDiv.classList.add("open");
        icon.style.transform = "rotate(180deg)";
      }
    });
    container.appendChild(item);
  });
}

/**
 * Loads FAQ entries and renders them as an accordion widget.
 * Attempts to load from Supabase if available, falling back to local/static data.
 */
window.MH_initFAQ = async function (supabaseInstance) {
  const container = document.getElementById("faqContainer");
  if (!container) return;

  // Immediate render from cache/static to avoid blank layout flash
  const initialFaqs = window.MH_getFAQs();
  renderFaqAccordion(initialFaqs, container);

  // If Supabase client is available, try fetching updated FAQs from cloud table
  const sb = supabaseInstance || window.MH?.supabase;
  if (sb) {
    try {
      const { data, error } = await sb
        .from("faqs")
        .select("id, question, answer, expires_at, is_active, display_order")
        .order("display_order", { ascending: true })
        .order("id", { ascending: true });

      if (!error && Array.isArray(data) && data.length > 0) {
        window.MH_saveFAQs(data);
        renderFaqAccordion(data, container);
      }
    } catch (e) {
      // Graceful fallback to static/local
    }
  }
};
