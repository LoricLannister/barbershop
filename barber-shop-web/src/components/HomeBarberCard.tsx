import styles from "./HomeBarberCard.module.css";

export default function HomeBarberCard() {
  return (
    <div class={styles.homeBarberCard}>
      <img src="/barbershopEg.jpg" alt="Barber" class={styles.homeBarberCardImage} />
      <div class={styles.homeBarberCardContent}>
        <span class={styles.openNow}>OPEN KNOW</span>
        <span class={styles.openAt}>from 9:00 to 21:00</span>
        <h2>ZEN BARBER</h2>
        <p>Experience the best haircut in town!</p>
      </div>
    </div>
  );
}
