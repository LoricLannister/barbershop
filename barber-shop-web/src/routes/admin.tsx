import { createAsync } from "@solidjs/router";
import { getBarbershops } from "./lib/barbershops";
import { useNavigate } from "@solidjs/router";
import styles from "./admin.module.css";

export default function Admin() {
  const saloons = createAsync(() => getBarbershops());
  const navigate = useNavigate();

  const isOpen = (openAt: string, closeAt: string) => {
    const now = new Date();
    const [openHour, openMin] = openAt.split(":").map(Number);
    const [closeHour, closeMin] = closeAt.split(":").map(Number);

    const openTime = new Date();
    openTime.setHours(openHour, openMin, 0);

    const closeTime = new Date();
    closeTime.setHours(closeHour, closeMin, 0);

    return now >= openTime && now <= closeTime;
  };

  return (
    <div class={styles.container}>
      <h1 class={styles.title}>Liste des Salons</h1>

      <button
        class={styles.createButton}
        onClick={() => navigate("/registerBarbershop")}
      >
        + Ajouter un Salon
      </button>

      <div class={styles.saloonList}>
        {saloons()?.map((saloon) => (
          <div
            class={styles.card}
            onClick={() => navigate(`/allBookings?barbershopId=${saloon.id}`)}
          >
            <img
              src="/barbershopEg.jpg"
              alt="Barbershop"
              class={styles.cardImage}
            />
            <div class={styles.cardContent}>
              <div class={styles.cardHeader}>
                <h2 class={styles.saloonName}>{saloon.name}</h2>
                <span
                  class={`${styles.status} ${
                    isOpen(saloon.openAt, saloon.closeAt)
                      ? styles.open
                      : styles.closed
                  }`}
                >
                  {isOpen(saloon.openAt, saloon.closeAt)
                    ? "🟢 Ouvert"
                    : "🔴 Fermé"}
                </span>
              </div>
              <p>
                <i class="fas fa-map-marker-alt"></i> {saloon.location}
              </p>
              <p>
                <i class="fas fa-clock"></i> {saloon.openAt} - {saloon.closeAt}
              </p>
              <p>
                <i class="fas fa-star"></i> Note : {saloon.rate.toFixed(1)}/5
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
