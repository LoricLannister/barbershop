import { useSubmission } from "@solidjs/router";
import styles from "./LoginForm.module.css";
import { loginAction } from "~/routes/lib/users";
import { createEffect } from "solid-js";

export default function LoginForm() {
  const submission = useSubmission(loginAction);

  // Rediriger après succès
  createEffect(() => {
    if (submission.result?.success && submission.result.redirectTo) {
      window.location.href = submission.result.redirectTo;
    }
  });

  return (
    <div class={styles.formContainer}>
      <h1 class={styles.title}>Welcome Back!</h1>

      <form method="post" action={loginAction} class={styles.form}>
        <input
          type="email"
          name="email"
          placeholder="Email"
          class={styles.input}
        />
        {submission.error?.message && (
          <p style="color: #ea4335;">{submission.error.message}</p>
        )}
        <input
          type="password"
          name="password"
          placeholder="Password"
          class={styles.input}
        />
        <div class={styles.forgotPassword}>
          <a href="#">Forget password?</a>
        </div>
        <button type="submit" class={styles.loginButton}>
          Login
        </button>
        <div class={styles.orLoginWith}>Or login with</div>
        <div class={styles.socialIcons}>
          <i class="fab fa-google" style="color: #ea4335;"></i>
          <i class="fab fa-facebook" style="color: #1877f2;"></i>
          <i class="fab fa-instagram" style="color: #e4405f;"></i>
        </div>
        <div class={styles.registerLink}>
          Don't have an account? <a href="/register">Register</a>
        </div>
      </form>
    </div>
  );
}
