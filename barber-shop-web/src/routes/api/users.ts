import prisma from "~/lib/db";
import { action, query, redirect } from "@solidjs/router";
import { z } from "zod";
import bcrypt from "bcryptjs";
import { useSession } from "vinxi/http";

const userSchema = z.object({
  username: z.string(),
  email: z.string().email(),
  password: z.string().min(6),
});

const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(6),
});

type SessionData = {
  email?: string;
};

function getSession() {
  "use server";
  return useSession<SessionData>({
    password: import.meta.env.VITE_SESSION_SECRET,
  });
}

export const addUser = async (form: FormData) => {
  "use server";
  let [username, email, password] = ["", "", ""];
  try {
    const user = userSchema.parse({
      username: form.get("username"),
      email: form.get("email"),
      password: form.get("password"),
    });
    username = user.username;
    email = user.email;
    password = user.password;
  } catch {
    throw new Error("Password too short");
  }
  // Vérifier si l'utilisateur existe déjà
  const existingUser = await prisma.user.findFirst({
    where: {
      OR: [{ email: email }, { username: username }],
    },
  });

  if (existingUser) {
    throw new Error("Email/username already used.");
  }

  password = await bcrypt.hash(password, 10);

  await prisma.user.create({ data: {username, email, password}});
  const session = await getSession();
  await session.update({ email: email });
  throw redirect("/booking");
};

export const login = async (form: FormData) => {
  "use server";
  let [email, password] = ["", ""];
  try {
    const data = loginSchema.parse({
      email: form.get("email"),
      password: form.get("password"),
    });
    email = data.email;
    password = data.password;
  } catch {
    throw new Error("Password too short");
  }
  // Vérifier si l'utilisateur existe
  const record = await prisma.user.findUnique({ where: { email } });
  if (!record) {
    throw new Error("Email/password incorrect");
  }
  // Vérifier le mot de passe
  const loggedIn = await bcrypt.compare(password, record.password);
  if (!loggedIn) {
    throw new Error("Email/password incorrect");
  }
  // Mettre à jour la session
  const session = await getSession();
  await session.update({ email });

  return redirect("/booking");
};

export async function logout () {
  "use server";
  const session = await getSession();
  await session.clear();
  return redirect("/login");
};

export const loginAction = action(login);
export const registerAction = action(addUser);
export const logoutAction = action(logout)

export const getCurrentUser = query(async () => {
  "use server";
  try {
  const session = await getSession();
  console.log("Session récupérée :", session);

  if (!session || !session.data.email) {
    console.warn("Aucun email trouvé dans la session.");
    return null;
  }

  const user = await prisma.user.findUnique({
    where: { email: session.data.email },
  });

  console.log("Utilisateur trouvé :", user);
  return user;
} catch {
  return null
}
}, "getCurrentUser");