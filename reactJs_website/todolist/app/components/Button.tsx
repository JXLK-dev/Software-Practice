import React, { useState } from "react";
import { FaPlus } from "react-icons/fa";

export const Button: React.FC = (props) => {
  const [isOpen, setIsOpen] = useState(false);
  const [task, setTask] = useState("");

  const handleClick = () => {
    setIsOpen(true);
  };

  const handleSubmit = () => {
    // Add your logic here to handle the submitted task
    setIsOpen(false);

    props.updateTaskList((prevstate) => [...prevstate, task]);
    setTask("");
  };

  const handleCancel = () => {
    setIsOpen(false);
    setTask("");
  };

  return (
    <>
      <button
        className="fixed bottom-0 -translate-y-10 bg-gradient-to-r from-pink-500 to-red-500 text-white px-4 py-2 rounded-md border-none flex items-center justify-center cursor-pointer"
        onClick={handleClick}
      >
        <FaPlus className="mr-2" />
        Add Task
      </button>

      {isOpen && (
        <div className="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50">
          <div className="bg-white p-4 rounded-md">
            <h2 className="text-xl font-semibold mb-2 text-black">Add Task</h2>
            <input
              type="text"
              value={task}
              onChange={(e) => setTask(e.target.value)}
              className="border border-gray-300 rounded-md px-2 py-1 mb-2 text-black"
            />
            <div className="flex justify-end">
              <button
                className="bg-blue-500 text-white px-4 py-2 rounded-md mr-2"
                onClick={handleSubmit}
              >
                Submit
              </button>
              <button
                className="bg-gray-500 text-white px-4 py-2 rounded-md"
                onClick={handleCancel}
              >
                Cancel
              </button>
            </div>
          </div>
        </div>
      )}
    </>
  );
};
