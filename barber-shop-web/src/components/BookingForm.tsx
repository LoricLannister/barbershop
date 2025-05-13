import styles from "./BookingForm.module.css";
import { createAsync, useSubmission, useSearchParams } from "@solidjs/router";
import { createEffect } from "solid-js";
import { bookingAction } from "~/routes/lib/appointments";
import { getCurrentUser } from "~/routes/lib/users";

export default function BookingForm() {
  const user = createAsync(() => getCurrentUser());
  const submission = useSubmission(bookingAction);
  const [params] = useSearchParams();
  const barbershopId = params.barbershopId;

  // Rediriger après succès
  createEffect(() => {
    if (submission.result?.success && submission.result.redirectTo) {
      window.location.href = submission.result.redirectTo;
    }
  });

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
          <input type="date" name="date" class={styles.input} required />
        </div>

        <div class={styles.inputGroup}>
          <label>Heure</label>
          <input type="time" name="time" class={styles.input} required />
        </div>

        <div class={styles.inputGroup}>
          <label>Type de coupe</label>
          <select name="haircut" class={styles.input} required>
            <option value="">Sélectionner une coupe</option>
            <option value="Classique">Classique</option>
            <option value="Dégradé">Dégradé</option>
            <option value="Rasé">Rasé</option>
            <option value="Rasé">Twists</option>
            <option value="Long">Long</option>
          </select>
        </div>

        {barbershopId && (
          <div class={styles.inputGroup}>
            <label>Salon sélectionné</label>
            <input
              type="text"
              name="barbershopId"
              value={barbershopId}
              readOnly
              class={styles.input}
            />
          </div>
        )}

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
