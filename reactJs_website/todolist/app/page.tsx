"use client";
import Image from "next/image";
import { Button } from "../app/components/Button";
import { ListTile } from "../app/components/ListTile";
import React from "react";

export default function Home() {
  const [task, setTask] = React.useState([]);
  let taskWidget: JSX.Element[] = [];
  task.forEach((element, index) => {
    taskWidget.push(
      <ListTile id={index} title={element} deleteTask={setTask} />
    );
  });
  return (
    <main className="flex min-h-screen flex-col items-center p-24 bg-gradient-to-r from-slate-500 to-yellow-300">
      <h1 className="text-6xl">TASK</h1>
      {taskWidget}
      <Button updateTaskList={setTask} />
    </main>
  );
}
