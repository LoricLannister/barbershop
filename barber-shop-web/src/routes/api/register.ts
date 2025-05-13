import type { APIEvent } from "@solidjs/start/server";
import { addUser } from "~/routes/lib/users";

export async function POST(event: APIEvent) {
  const formData = await event.request.formData();
  try {
    const response = await addUser(formData);
    return response;
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return new Response(JSON.stringify({ success: false, message }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }
}
