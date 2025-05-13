import { getBarbershops } from "~/routes/lib/barbershops";

export async function GET() {
  try {
    const response = await getBarbershops();
    return response;
  } catch (error) {
    const message = error instanceof Error ? error.message : "Unknown error";
    return new Response(JSON.stringify({ success: false, message }), {
      status: 400,
      headers: { "Content-Type": "application/json" },
    });
  }
}
