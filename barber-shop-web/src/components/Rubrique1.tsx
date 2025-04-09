import styles from "./Rubrique1.module.css";

export default function Rubrique1() {
    return (
        <div class= {styles.spacer}>
            <span class= {styles.nearbyBarberShopLeft}>Nearby Barbershops</span>
            <span class= {styles.nearbyBarberShopRight}>View All &gt;</span>
        </div>
    );
}