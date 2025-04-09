import { Title } from "@solidjs/meta";
import HomeBarberCard from "~/components/HomeBarberCard";
import Navbar from "~/components/Navbar";
import Rubrique1 from "~/components/Rubrique1";
import Rubrique2 from "~/components/Rubrique2";
import styles from "../components/HomeBarberCard.module.css";
import "./index.module.css";

export default function Home() {
  return (
    <div>
          <Title>BarberShop</Title>
          <Navbar/>
          <Rubrique1/>
          <div class= {styles.homeNearbyCard}>
            <HomeBarberCard showBadge={false} />
            <HomeBarberCard showBadge={false} />
            <HomeBarberCard showBadge={false} />
          </div>
          <Rubrique2/>
          <div class= {styles.homeNearbyCard}>
            <HomeBarberCard showBadge={true} rating={4.6} />
            <HomeBarberCard showBadge={true} rating={4.7} />
            <HomeBarberCard showBadge={true} rating={4.8} />
          </div>
    </div>
  );
}
