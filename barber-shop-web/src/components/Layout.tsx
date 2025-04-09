import { Meta } from "@solidjs/meta";
import { action, createAsync, redirect } from "@solidjs/router";
import { createSignal, JSXElement, onCleanup, Show } from "solid-js";
import { getCurrentUser } from "~/routes/api/users";
import styles from "./Layout.module.css";

const redirectAction = action(async () => {
  "use server";
  throw redirect("/login");
});

export default function Layout(props: {
  children: JSXElement;
  protected?: boolean;
}) {
  const currentUser = createAsync(() => getCurrentUser());
  const [countDown, setCountDown] = createSignal(3)

  const handleCountDown = setInterval(() => {
    if (countDown() > 0) {
      setCountDown((prev) => prev - 1)
    }
  }, 1000)

  onCleanup(() => {
    clearInterval(handleCountDown)
  })

  return (
    <Show
      when={!props.protected || currentUser()}
      fallback={
        <div class={styles.container}>
          <Show when={currentUser() === null}>
            <Meta http-equiv="refresh" content="3;url=/login" />
          </Show>
          <p class={styles.title}>Pas connecté, redirection vers la page de login dans {countDown()} secondes...</p>
          <form method="post" action={redirectAction}>
            <button class={styles.redirectionButton} type="submit">Redirection</button>
          </form>
        </div>
      }
    >
      {props.children}
    </Show>
  );
}
