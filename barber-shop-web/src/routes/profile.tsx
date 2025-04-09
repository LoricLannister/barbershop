import { Title } from "@solidjs/meta";
import ProfileInfo from "~/components/ProfileInfo";
import CircleAvatar from "~/components/CircleAvatar";
import styles from "./profile.module.css";
import Layout from "~/components/Layout";

export default function Profile() {
  return (
    <Layout protected>
      <Title>BarberShop-Profile</Title>
      <CircleAvatar/>
      <hr class={styles.divider}/>
      <ProfileInfo/>
    </Layout>
  );
}
