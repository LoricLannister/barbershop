import { getCurrentUser } from "~/routes/api/users";
import styles from "./HomeBarberCard.module.css";
import { action, redirect } from "@solidjs/router";

interface HomeBarberCardProps {
  showBadge?: boolean;
  rating?: number;
}

const redirectAction = action(async () => {
  "use server";
  const user = await getCurrentUser();
  if (user) {
    throw redirect("/booking");
  } else {
    throw redirect("/login");
  }
});

export default function HomeBarberCard(props: HomeBarberCardProps) {
  return (
    <div class={styles.homeBarberCard}>
      <div class={styles.homeBarberCardImageWrapper}>
        <img
          src="/barbershopEg.jpg"
          alt="Barber"
          class={styles.homeBarberCardImage}
        />
        {props.showBadge && (
          <div class={styles.ratingBadge}>
            <i class="fas fa-star"></i>
            <span>{props.rating}</span>
          </div>
        )}
      </div>
      <div class={styles.homeBarberCardContent}>
        <span class={styles.openNow}>OPEN KNOW</span>
        <span class={styles.openAt}>from 9:00 to 21:00</span>
        <h2>ZEN BARBER</h2>
        <i
          class="fas fa-crosshairs locationIcon"
          style={{ color: "#ffc107" }}
        ></i>
        <span class={styles.distance}>0.9 km</span>
        <form method="post" action={redirectAction}>
        <button class={styles.bookButton} type="submit">
          BOOK NOW
        </button>
        </form>
      </div>
    </div>
  );
}
