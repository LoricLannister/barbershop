import type { APIEvent } from "@solidjs/start/server";
import { getAppointmentsByBarbershopId } from "~/routes/lib/appointments";

export async function GET(event: APIEvent) {
    const barbershopId = event.params.barbershopId;
  try {
    const response = await getAppointmentsByBarbershopId(barbershopId);
    return response;
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return new Response(JSON.stringify({ success: false, message }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }
}
