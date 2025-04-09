import styles from "./BookingForm.module.css";
import { createAsync, useSubmission } from "@solidjs/router";
import { bookingAction } from "~/routes/api/appointments";
import { getCurrentUser } from "~/routes/api/users";

export default function BookingForm() {
  const user = createAsync(() => getCurrentUser());
  const submission = useSubmission(bookingAction);

  return (
    <div class={styles.formContainer}>
      <h1 class={styles.title}>Réservez pour une coupe de cheveux</h1>
        <form method="post" action={bookingAction} class={styles.form}>
          <div class={styles.inputGroup}>
            <label>Nom</label>
            <input
              type="text"
              name="name"
              value={user()?.username}
              readOnly
              class={styles.input}
            />
          </div>

          <div class={styles.inputGroup}>
            <label>Email</label>
            <input
              type="email"
              name="email"
              value={user()?.email}
              readOnly
              class={styles.input}
            />
          </div>

          <div class={styles.inputGroup}>
            <label>Date</label>
            <input
              type="date"
              name="date"
              class={styles.input}
              required
            />
          </div>

          <div class={styles.inputGroup}>
            <label>Heure</label>
            <input
              type="time"
              name="time"
              class={styles.input}
              required
            />
          </div>

          <div class={styles.inputGroup}>
            <label>Type de coupe</label>
            <select
              class={styles.input}
              required
            >
              <option value="">Sélectionner une coupe</option>
              <option value="Classique">Classique</option>
              <option value="Dégradé">Dégradé</option>
              <option value="Rasé">Rasé</option>
              <option value="Rasé">Twists</option>
              <option value="Long">Long</option>
            </select>
          </div>
          {submission.error?.message && (
          <p style="color: #ea4335;">{submission.error.message}</p>
          )}
          <button type="submit" class={styles.bookingButton}>
            Réserver
          </button>
        </form>
    </div>
  );
}
