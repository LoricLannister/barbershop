import { createSignal, onMount } from "solid-js";
import styles from "./ProfileInfo.module.css";
import { createAsync, query, revalidate } from "@solidjs/router";
import { getCurrentUser, logout, logoutAction } from "~/routes/lib/users";
import { isServer } from "solid-js/web";

const getLocation = query(async () => {
  if (isServer || !navigator.geolocation) {
    return null;
  }
  return new Promise<string>((resolve, reject) => {
    navigator.geolocation.getCurrentPosition(
      async (position) => {
        const { latitude, longitude } = position.coords;

        try {
          const response = await fetch(
            `https://nominatim.openstreetmap.org/reverse?lat=${latitude}&lon=${longitude}&format=json`
          );
          const data = await response.json();
          const address = data.address;
          const locationText =
            `${address.city}, ${address.country}` ||
            `${address.town}, ${address.country}` ||
            `${address.village}, ${address.country}` ||
            `${address.state}, ${address.country}` ||
            "Localisation inconnue";

          resolve(locationText);
        } catch (error) {
          console.error("Erreur lors du reverse geocoding :", error);
          reject("Erreur de localisation");
        }
      },
      () => {
        reject("Localisation refusée");
      }
    );
  });
}, "getLocation");

export default function ProfileInfo() {
  const user = createAsync(() => getCurrentUser());
  const location = createAsync(() => getLocation());

  setInterval(() => {
    revalidate(getLocation.key);
  }, 3600);

  return (
    <div class={styles.profileBody}>
      <div class={styles.emailItem}>
        <i class="fas fa-envelope"></i>
        <span style={{ "padding-left": "16px" }}>{user()?.email}</span>
      </div>
      <div class={styles.locationItem}>
        <i class="fas fa-map-marker-alt"></i>
        <span style={{ "padding-left": "16px" }}>{location()}</span>
      </div>
      <form method="post" class={styles.SignOutItem} action={logoutAction}>
        <button
          class={styles.SignOutItem}
          type="submit"
          style={{ cursor: "pointer" }}
        >
          <i class="fas fa-sign-out-alt"></i>
          <span style={{ "padding-left": "16px" }}>Logout</span>
        </button>
      </form>
    </div>
  );
}
