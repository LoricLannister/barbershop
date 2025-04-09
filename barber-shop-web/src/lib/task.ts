import { action, query } from "@solidjs/router";
import { db } from "./db";
import { z } from 'zod';

const taskSchema = z.object({
  title: z.string(),
  completed: z.boolean(),
})

export const getTasks = query(async () => {
    'use server'
    return await db.task.findMany()
  }, 'getTasks')

export const addTask = action(async (form: FormData) => {
  'use server'
  const task = taskSchema.parse({
    title: form.get('title'),
    completed: false,
  })
  return await db.task.create({ data: task })
})

export const removeTask = action(async (id: number) => {
  'use server'
  return await db.task.delete({ where: { id } })
})