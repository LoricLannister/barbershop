import { createSignal } from "solid-js";
import { action, redirect } from "@solidjs/router";
import styles from "./Booking.module.css";
import BookingForm from "~/components/BookingForm";
import Layout from "~/components/Layout";

export default function Booking() {
  return (
    <Layout protected>
      <div class={styles.container}>
        <div class={styles.left}>
          <img src="/starting.jpg" alt="Background" class={styles.image} />
        </div>
        <BookingForm/>
      </div>
    </Layout>
  );
}
