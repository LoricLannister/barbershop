import { getCurrentUser } from "~/routes/lib/users";
import styles from "./HomeBarberCard.module.css";
import { action, redirect } from "@solidjs/router";

interface HomeBarberCardProps {
  name: string;
  location: string;
  rating?: number;
  showBadge?: boolean;
  openAt: string;
  closeAt: string;
  distance?: string;
  id: string;
}

const redirectAction = action(async (id: string) => {
  "use server";
  const user = await getCurrentUser();
  if (user) {
    throw redirect(`/booking?barbershopId=${id}`);
  } else {
    throw redirect("/login");
  }
});

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

export default function HomeBarberCard(props: HomeBarberCardProps) {
  return (
    <div class={styles.homeBarberCard}>
      <div class={styles.homeBarberCardImageWrapper}>
        <img
          src="/barbershopEg.jpg"
          alt="Barber"
          class={styles.homeBarberCardImage}
        />
        {props.showBadge && props.rating && (
          <div class={styles.ratingBadge}>
            <i class="fas fa-star"></i>
            <span>{props.rating.toFixed(1)}</span>
          </div>
        )}
      </div>
      <div class={styles.homeBarberCardContent}>
        <span class={styles.openNow}>{isOpen(props.openAt, props.closeAt)
                    ? "OPEN NOW"
                    : "CLOSED NOW"}</span>
        <span class={styles.openAt}>
          from {props.openAt} to {props.closeAt}
        </span>
        <h2>{props.name}</h2>
        <div class={styles.locationRow}>
          <i class="fas fa-crosshairs locationIcon" style={{ color: "#ffc107" }}></i>
          <span class={styles.distance}>{props.distance ?? "1.2 km"}</span>
        </div>
        <form method="post" action={redirectAction.with(props.id)}>
          <button class={styles.bookButton} type="submit">
            BOOK NOW
          </button>
        </form>
      </div>
    </div>
  );
}
