import { createAsync } from "@solidjs/router";
import styles from "./CircleAvatar.module.css";
import { getCurrentUser } from "~/routes/lib/users";

export default function CircleAvatar() {
    const user = createAsync(() => getCurrentUser());

    return (
        <div class={styles.avatarContainer}>
            <img src="/avatar.jpg" alt="User Avatar" class={styles.avatar} />
            <button class= {styles.cameraBtn}>
                <i class="fas fa-camera" style={{"font-size": "20px"}}></i>
            </button>
            <p class={styles.name}>{user()?.username}</p>
            <hr class={styles.divider}/>
        </div>
    );
}