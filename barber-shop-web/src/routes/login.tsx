import { Title } from "@solidjs/meta";
import styles from "./login.module.css";
import LoginForm from "~/components/LoginForm";

export default function Login() {

  return (
    <div>
      <Title>BarberShop-Login</Title>
      <div class={styles.container}>
        <div class={styles.left}>
          <img src="/starting.jpg" alt="Background" class={styles.image} />
          <div class={styles.overlayImages}>
            <img src="/logo.png" alt="logo" class={styles.smallLogo} />
            <img
              src="/branding.png"
              alt="branding"
              class={styles.smallBranding}
            />
          </div>
        </div>
        <LoginForm/>
      </div>
    </div>
  );
}
