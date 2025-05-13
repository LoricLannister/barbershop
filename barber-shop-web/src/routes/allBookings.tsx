import styles from "./allBookings.module.css";
import { useSearchParams, useNavigate } from "@solidjs/router";
import { createAsync } from "@solidjs/router";
import { getAppointmentsByBarbershopId } from "./lib/appointments";

export default function AdminBooking() {
  const [params] = useSearchParams();
  const navigate = useNavigate();

  const appointments = createAsync(() => {
    if (!params.barbershopId || Array.isArray(params.barbershopId)) {
      throw new Error("ID du salon manquant ou invalide.");
    }
    return getAppointmentsByBarbershopId(params.barbershopId);
  });

  return (
    <div class={styles.container}>
      <h1 class={styles.title}>📅 Rendez-vous programmés</h1>

      <button class={styles.backButton} onClick={() => navigate("/admin")}>
        ⬅ Retour à l'admin
      </button>

      <div class={styles.list}>
        {appointments() === undefined && (
          <div class={styles.loaderWrapper}>
            <div class={styles.loader}></div>
            <p>Chargement des rendez-vous...</p>
          </div>
        )}

        {appointments() !== undefined && appointments()?.length === 0 && (
          <p class={styles.emptyMessage}>Aucun rendez-vous pour ce salon pour le moment.</p>
        )}

        {appointments()?.map((a) => (
          <div class={styles.card}>
            <img src="/avatar.jpg" alt="avatar" class={styles.avatar} />
            <div>
              <h2>{a.user.username}</h2>
              <p><strong>Email :</strong> {a.user.email}</p>
              <p><strong>Date :</strong> {new Date(a.date).toLocaleDateString()}</p>
              <p><strong>Heure :</strong> {new Date(a.date).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}</p>
              <p><strong>Coupe :</strong> {a.haircut}</p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
