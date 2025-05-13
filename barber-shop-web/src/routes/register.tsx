import { Title } from "@solidjs/meta";
import styles from "./register.module.css";
import { registerAction } from "./lib/users";
import { useSubmission } from "@solidjs/router";
import { createEffect } from "solid-js";

export default function Register() {
  const submission = useSubmission(registerAction);

  // Rediriger après succès
  createEffect(() => {
    if (submission.result?.success && submission.result.redirectTo) {
      window.location.href = submission.result.redirectTo;
    }
  });

  return (
    <div>
      <Title>BarberShop-Register</Title>
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
        <div class={styles.formContainer}>
          <h1 class={styles.title}>Create Account!</h1>

          <form method="post" action={registerAction} class={styles.form}>
            <input
              type="text"
              name="username"
              placeholder="Username"
              class={styles.input}
            />
            <input
              type="email"
              name="email"
              placeholder="Email"
              class={styles.input}
            />
            <input
              type="password"
              name="password"
              placeholder="Password"
              class={styles.input}
            />
            {submission.error?.message && (
              <p style="color: #ea4335;">{submission.error.message}</p>
            )}
            <button type="submit" class={styles.registerButton}>
              Register
            </button>

            <div class={styles.orLoginWith}>Or login with</div>

            <div class={styles.socialIcons}>
              <i class="fab fa-google" style="color: #ea4335;"></i>
              <i class="fab fa-facebook" style="color: #1877f2;"></i>
              <i class="fab fa-instagram" style="color: #e4405f;"></i>
            </div>

            <div class={styles.registerLink}>
              Already have an account? <a href="/login">Login</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
}
