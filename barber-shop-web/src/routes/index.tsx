import { Title } from "@solidjs/meta";
import { createAsync } from "@solidjs/router";
import Navbar from "~/components/Navbar";
import Rubrique1 from "~/components/Rubrique1";
import Rubrique2 from "~/components/Rubrique2";
import HomeBarberCard from "~/components/HomeBarberCard";
import styles from "../components/HomeBarberCard.module.css";
import "./index.module.css";
import { getBarbershops } from "./lib/barbershops";

export default function Home() {
  const barbershops = createAsync(() => getBarbershops());

  return (
    <div>
      <Title>BarberShop</Title>
      <Navbar />
      <Rubrique1 />
      <div class={styles.homeNearbyCard}>
        {barbershops()
          ?.slice(0, 3)
          .map((shop) => (
            <HomeBarberCard
              name={shop.name}
              location={shop.location}
              openAt={shop.openAt}
              closeAt={shop.closeAt}
              rating={shop.rate}
              id={shop.id}
              showBadge={false}
            />
          ))}
      </div>
      <Rubrique2 />
      <div class={styles.homeNearbyCard}>
        {barbershops()
          ?.sort((a, b) => b.rate - a.rate)
          .slice(0, 3)
          .map((shop) => (
            <HomeBarberCard
              name={shop.name}
              location={shop.location}
              openAt={shop.openAt}
              closeAt={shop.closeAt}
              rating={shop.rate}
              id={shop.id}
              showBadge={true}
            />
          ))}
      </div>
    </div>
  );
}
