import { query } from "@solidjs/router";
import prisma from "~/lib/db";
import { z } from "zod";
import { getCurrentUser } from "./users";

const barbershopSchema = z.object({
  name: z.string(),
  location: z.string(),
  openAt: z.string(),
  closeAt: z.string(),
  rate: z.number(),
});

export const getBarbershops = query(async () => {
  "use server";
  return await prisma.barbershop.findMany();
}, "getBarbershops");

//Add a barbershop linked to specific user which is owner
export const addBarbershop = async (form: FormData) => {
  "use server";
  
  const user = await getCurrentUser();
  if (!user) throw new Error("Unauthorized - You must be logged in.");
  const ownerId = user.id;

  const barbershop = barbershopSchema.parse({
    name: form.get("name"),
    location: form.get("location"),
    openAt: form.get("openAt"),
    closeAt: form.get("closeAt"),
    rate: 4.0,
  });
  await prisma.barbershop.create({
    data: {
      ...barbershop,
      ownerId, // Lien vers l'utilisateur
    },
  });
};
