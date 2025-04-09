// ~/context/userContext.ts
import { createContext, useContext } from "solid-js";
import type { Accessor } from "solid-js";

type User = {
  id: string;
  username: string;
  email: string;
  // Tu peux aussi omettre `password` ici si tu ne veux pas l’exposer
};

const UserContext = createContext<Accessor<User | null | undefined>>();

export function useUser() {
  const ctx = useContext(UserContext);
  if (!ctx) throw new Error("useUser must be used within a <UserProvider />");
  return ctx;
}

export default UserContext;
