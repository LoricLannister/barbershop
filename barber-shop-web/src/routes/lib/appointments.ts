import prisma from "~/lib/db";
import { getCurrentUser } from "./users";
import { z } from "zod";
import { action } from "@solidjs/router";

// Validation des données du formulaire avec Zod
const appointmentSchema = z.object({
  barbershopId: z.string().min(1, "Barbershop ID is required"),
  date: z.coerce.date(), // Convertir en Date object
  haircut: z.string(),
});

export const bookAppointment = async (form: FormData) => {
  "use server";

  // 1. Récupérer l'utilisateur connecté via la session
  const user = await getCurrentUser();
  if (!user) throw new Error("Unauthorized - You must be logged in.");
  const userId = user.id;
  // 2. Valider les données
  const { barbershopId, date, haircut } = appointmentSchema.parse({
    barbershopId: form.get("barbershopId"),
    date: form.get("date"),
    haircut: form.get("haircut"),
  });
  console.log("etape 2 done")

  // 3. Vérifier si le barbershop existe
  const barbershop = await prisma.barbershop.findUnique({
    where: { id: barbershopId },
  });
  if (!barbershop) throw new Error("Barbershop not found.");

  // 4. Créer le rendez-vous
  await prisma.appointment.create({
    data: {
      userId,
      barbershopId,
      date,
      haircut,
      status: "confirmed",
    },
  });
  return { success: true, redirectTo: "/" };
};

export const getUserAppointments = async () => {
  "use server";

  const user = await getCurrentUser();
  if (!user) throw new Error("Unauthorized - You must be logged in.");
  const userId = user.id;

  return await prisma.appointment.findMany({
    where: { userId },
    include: {
      barbershop: true,
    },
    orderBy: { date: "asc" },
  });
};

export const getAppointmentsByBarbershopId = async (barbershopId: string) => {
  "use server";

  return await prisma.appointment.findMany({
    where: { barbershopId },
    include: {
      user: true,
      barbershop: true,
    },
    orderBy: {
      date: "asc",
    },
  });
};

export const bookingAction = action(bookAppointment);
export const getAppointmentsAction = action(getUserAppointments);