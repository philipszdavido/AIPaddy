# Ideas for making AIPaddy great

## Fix the foundations first

- **Real conversation memory.** `AIViewModel.sendMessage` creates a new `LanguageModelSession` for every message, so the model forgets everything said earlier. Keep one session per `Chat` (e.g. a `[PersistentIdentifier: LanguageModelSession]` cache). When an app relaunch drops the cache, rebuild it from stored messages using a `Transcript`.
- **Model availability handling.** Check `SystemLanguageModel.default.availability` at launch. Show a clear screen for `.deviceNotEligible`, `.appleIntelligenceNotEnabled`, and `.modelNotReady`, so the user never sees a silent "Error occurred.".
- **Visible, specific errors.** The `update` callback is a no-op, so errors never show up. Write the error into the AI message itself, and handle `LanguageModelSession.GenerationError` cases (`exceededContextWindowSize`, `guardrailViolation`, `unsupportedLanguageOrLocale`) with a useful message for each.
- **Ghost chat bug.** When no chat is selected, `ContentView` passes an uninserted `Chat` to `ChatAreaView`. Messages sent there end up linked to a chat that's never in the sidebar. Create and insert the chat lazily on the first send, or show `ContentUnavailableView` (already commented out).
- **Stop button and no double sends.** Disable the send button while streaming, ignore empty input, and let the user cancel the running `Task`.
- **Lower the temperature.** `GenerationOptions(temperature: 2.0)` is defined but never used, and 2.0 is very high. Expose it as a setting instead (e.g. Precise / Balanced / Creative).
- **Concurrency cleanup.** Turn `AIViewModel` into an `@Observable @MainActor` class owned per chat, not a global singleton. Drop the `Combine` import and the unused `palId` / `update` params.
- **Replace `try!`** in `clearAll()`, and add a confirmation dialog before deleting everything.

## Make it feel like a great chat app

- **Markdown rendering** in `MessageRow` (`Text(AttributedString(markdown:))`, or a proper Markdown view for code blocks with copy buttons).
- **Message actions:** copy, regenerate, edit-and-resend, and delete one message.
- **Typing indicator:** show an animated "…" bubble in place of the literal "Typing..." string.
- **Multiline composer:** `TextField(axis: .vertical)`, ⌘↩ to send, and focus the input on launch.
- **Rename chats** from the sidebar, plus pin and archive.
- **Search** across all chats and messages (SwiftData `#Predicate` on `Message.content`).
- **Keyboard shortcuts:** ⌘N for a new chat, ⌘⌫ to delete a chat, ⌘F to search.
- **Group the sidebar by date** (Today, Yesterday, Previous 7 days).
- **Export a chat** as Markdown or PDF, and share it via `ShareLink`.

## Personas ("Pals")

The unused `palId` parameter hints at this already.
- Add a `Pal` `@Model` with a name, icon, and instructions. Ship a few built-ins (Tutor, Code Helper, Writing Coach, ELI5 — the current `Instructions.god`), and let users create their own.
- Pick a Pal per chat; it becomes the session `instructions`.
- Add a persona picker on the empty "Ask me anything" screen, with suggested starter prompts for each Pal.

## Use more of FoundationModels

- **Tool calling:** give the model `Tool`s for the date and time, a calculator, unit conversion, searching past chats, reading a dropped file, and Calendar/Reminders via EventKit (with permission).
- **Guided generation (`@Generable`):** structured outputs such as flashcards or quizzes generated from a conversation (this fits the app's "education" category), and to-do extraction. Render them as native UI, not text.
- **Summarize the chat** with one click, and use auto-summaries to stay inside the context window on long chats.
- **Better titles:** retitle after a few turns instead of only after the first message, and use `@Generable` to force the ≤5-word format.
- **Prewarm** the session (`session.prewarm()`) when the composer gets focus, for faster first tokens.

## Learning-focused features (education angle)

- A "Teach me" mode that explains step by step, then quizzes the user and tracks scores.
- Flashcard decks generated from any chat, with spaced-repetition review.
- A "Explain simpler / go deeper" slider that re-asks the same question at different levels.

## Platform reach

- iOS/iPadOS target that shares the models and views.
- CloudKit sync for chats (SwiftData + CloudKit; this needs optional or defaulted properties on the models).
- App Intents and Shortcuts: "Ask AIPaddy…" from Spotlight/Siri, and a menu bar quick-ask window.
- A Services menu and Share extension: "Explain selected text with AIPaddy".

## Quality

- Unit tests with an in-memory `ModelContainer` for `SwiftDataUtils` and chat lifecycle (cascade delete, title generation trigger).
- Abstract the model behind a protocol so tests and previews can use a fake streaming responder (also fixes the commented-out `MessageRow` preview).
- Fix the typo "Expalin" in `Instructions.god`, and consider rewording the "all knowing god" prompt to something like "patient expert teacher" for more grounded answers.
- Accessibility: VoiceOver labels on bubbles, Dynamic Type, and enough contrast in dark mode for the gray AI bubble.
