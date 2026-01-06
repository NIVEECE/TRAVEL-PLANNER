import tkinter as tk
from model2 import predict

root = tk.Tk()
root.title("AI Smart Travel Planner")
root.geometry("600x500")
root.configure(bg="#1e1e2f")

# -------- Frames --------
welcome_frame = tk.Frame(root, bg="#1e1e2f")
input_frame = tk.Frame(root, bg="#1e1e2f")
result_frame = tk.Frame(root, bg="#1e1e2f")

for frame in (welcome_frame, input_frame, result_frame):
    frame.place(relwidth=1, relheight=1)

def show_frame(frame):
    frame.tkraise()

# -------- Page 1: Welcome --------
tk.Label(welcome_frame, text="AI Smart Travel Planner",
         font=("Arial", 24, "bold"), fg="cyan", bg="#1e1e2f").pack(pady=30)

tk.Label(welcome_frame, text="🚆 ✈️ 🚌",
         font=("Arial", 30), bg="#1e1e2f").pack()

tk.Label(welcome_frame,
         text="Plan your journey intelligently\nusing Artificial Intelligence",
         fg="white", bg="#1e1e2f",
         font=("Arial", 12)).pack(pady=20)

tk.Button(welcome_frame, text="Start Planning",
          bg="cyan", fg="black",
          font=("Arial", 13, "bold"),
          command=lambda: show_frame(input_frame)
          ).pack(pady=40)

# -------- Page 2: Input --------
tk.Label(input_frame, text="Enter Travel Distance (km)",
         font=("Arial", 20, "bold"),
         fg="cyan", bg="#1e1e2f").pack(pady=40)

distance_entry = tk.Entry(input_frame, font=("Arial", 16), width=10)
distance_entry.pack(pady=10)

def calculate():
    user_input = distance_entry.get()

    if not user_input.isdigit():
        result_label.config(
            text="❌ Please enter distance in numbers only (eg: 200)"
        )
        show_frame(result_frame)
        return

    distance = int(user_input)
    mode, price = predict(distance)

    result_label.config(
        text=f"🚀 Recommended Mode: {mode}\n💰 Estimated Price: ₹{price}"

    )
    show_frame(result_frame)


tk.Button(input_frame, text="Find Best Option",
          bg="cyan", fg="black",
          font=("Arial", 12, "bold"),
          command=calculate).pack(pady=30)

# -------- Page 3: Result --------
tk.Label(result_frame, text="AI Recommendation",
         font=("Arial", 22, "bold"),
         fg="cyan", bg="#1e1e2f").pack(pady=30)

result_label = tk.Label(result_frame, text="",
                        font=("Arial", 16),
                        fg="white", bg="#1e1e2f")
result_label.pack(pady=20)

tk.Button(result_frame, text="Plan Another Trip",
          bg="cyan", fg="black",
          font=("Arial", 12, "bold"),
          command=lambda: show_frame(input_frame)
          ).pack(pady=30)

show_frame(welcome_frame)
root.mainloop()
