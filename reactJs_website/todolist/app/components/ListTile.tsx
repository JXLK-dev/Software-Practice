import React, { useState } from "react";

export const ListTile: React.FC<{
  title: string;
  id: number;
  deleteTask: any;
}> = ({ title, id, deleteTask }) => {
  const [isChecked, setIsChecked] = useState(false);

  const handleCheckboxChange = () => {
    setIsChecked(!isChecked);
  };

  const handleDeleteClick = () => {
    // Add your logic here for handling delete button click
    deleteTask((prevState: any) =>
      prevState.filter((_: any, index: number) => index !== id)
    );
  };

  return (
    <div
      className={`flex items-center justify-between p-4 border-b w-full md:w-3/4 sm:w-10/12 lg:w-1/2 ${
        isChecked ? "line-through" : ""
      }`}
    >
      <div className="flex items-center">
        <div>
          <input
            type="checkbox"
            className="form-checkbox"
            onChange={handleCheckboxChange}
          />
          <span className="ml-10">{title}</span>
        </div>
      </div>
      <button
        className="px-4 py-2 text-white bg-red-500 rounded"
        onClick={handleDeleteClick}
      >
        Delete
      </button>
    </div>
  );
};
