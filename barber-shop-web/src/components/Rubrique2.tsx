import styles from "./Rubrique2.module.css";

export default function Rubrique2() {
    return (
        <div class= {styles.spacer}>
            <span class= {styles.nearbyBarberShopLeft}>Top ranked</span>
            <span class= {styles.nearbyBarberShopRight}>View All &gt;</span>
        </div>
    );
}