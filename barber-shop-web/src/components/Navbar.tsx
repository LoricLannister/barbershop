import { createAsync } from "@solidjs/router";
import styles from "./Navbar.module.css";
import { getCurrentUser } from "~/routes/lib/users";

export default function Navbar() {
  const user = createAsync(() => getCurrentUser());

  return (
    <nav class={styles.navbar}>
      <div class={styles.navLeft}>
        {user()?.isAdmin ? (
          <a href="/admin">
            <img src="/logo.png" alt="barberShop" class={styles.navIcon} />
          </a>
        ) : (
          <img src="/logo.png" alt="barberShop" class={styles.navIcon} />
        )}
        <img src="/branding.png" alt="barberShop" class={styles.navBranding} />
        <input type="text" placeholder="Search..." class={styles.searchBar} />
        <h2 class={styles.navbarUsername}>
          {user()?.username ? <>Hey, {user()?.username}</> : <>Hello</>}
        </h2>
        {user() && (
          <a href="/profile" class={styles.userIcon}>
            <i
              class="fas fa-user"
              style={{ color: "#ffc107", "font-size": "28px" }}
            />
          </a>
        )}
        {user() && (
          <a href="/booked" class={styles.userIcon}>
            <i
              class="fas fa-calendar-check"
              style={{ color: "#ffc107", "font-size": "28px" }}
            ></i>
          </a>
        )}
      </div>
    </nav>
  );
}
