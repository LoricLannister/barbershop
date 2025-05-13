import type { APIEvent } from "@solidjs/start/server";
import { addBarbershop } from "~/routes/lib/barbershops";

export async function POST(event: APIEvent) {
  const formData = await event.request.formData();
  try {
    const response = await addBarbershop(formData);
    return response;
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return new Response(JSON.stringify({ success: false, message }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }
}
