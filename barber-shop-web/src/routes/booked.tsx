import { Title } from "@solidjs/meta";
import { createAsync } from "@solidjs/router";
import { For, Show } from "solid-js";
import Layout from "~/components/Layout";
import styles from "./booked.module.css";
import { getCurrentUser } from "~/routes/lib/users";
import { getUserAppointments } from "~/routes/lib/appointments";

export default function Profile() {
  const appointments = createAsync(async () => {
    const user = await getCurrentUser();
    if (!user) throw new Error("Utilisateur non connecté.");
    return getUserAppointments();
  });

  return (
    <Layout protected>
      <Title>BarberShop - Mes Rendez-vous</Title>
      <h1 class={styles.title}>Mes Rendez-vous</h1>
      <Show when={appointments()} fallback={<p>Chargement des rendez-vous...</p>}>
        <Show when={appointments() && appointments()!.length > 0} fallback={<p style={"color: #ffc107;"}>Vous n'avez aucun rendez-vous pour le moment.</p>}>
          <div class={styles.cardContainer}>
            <For each={appointments()}>
              {(appointment) => (
                <div class={styles.card}>
                  <h2>{appointment.barbershop.name}</h2>
                  <p>Adresse : {appointment.barbershop.location}</p>
                  <p>Date : {new Date(appointment.date).toLocaleDateString()}</p>
                  <p>Heure : {new Date(appointment.date).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</p>
                  <p>Type de coupe : {appointment.haircut}</p>
                </div>
              )}
            </For>
          </div>
        </Show>
      </Show>
    </Layout>
  );
}
