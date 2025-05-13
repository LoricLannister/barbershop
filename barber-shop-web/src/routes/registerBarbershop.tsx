import styles from "./registerBarbershop.module.css";
import { addBarbershopAction } from "./lib/barbershops";
import { useSubmission } from "@solidjs/router";
import { createEffect } from "solid-js";

export default function RegisterSaloon() {
  const submission = useSubmission(addBarbershopAction);

  // Rediriger après succès
  createEffect(() => {
    if (submission.result?.success && submission.result.redirectTo) {
      window.location.href = submission.result.redirectTo;
    }
  });

  return (
    <div class={styles.container}>
      <div class={styles.formCard}>
        <h1 class={styles.title}>📍 Ajouter un nouveau Salon</h1>
        <form method="post" action={addBarbershopAction} class={styles.form}>
          <input type="text" name="name" placeholder="Nom du salon" required />
          <input type="text" name="location" placeholder="Adresse" required />

          <div class={styles.timeFields}>
            <div class={styles.timeInput}>
              <label for="openAt">Heure d'ouverture</label>
              <input id="openAt" type="time" name="openAt" required />
            </div>

            <div class={styles.timeInput}>
              <label for="closeAt">Heure de fermeture</label>
              <input id="closeAt" type="time" name="closeAt" required />
            </div>
          </div>

          {submission.error?.message && (
            <p class={styles.error}>{submission.error.message}</p>
          )}

          <button type="submit" class={styles.submitButton}>
            Créer le Salon
          </button>
        </form>
      </div>
    </div>
  );
}
