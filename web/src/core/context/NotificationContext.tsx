import React, { createContext, useContext, useState, useEffect } from "react";

export interface Notification {
  id: string;
  title: string;
  description: string;
  timestamp: string;
  isRead: boolean;
  type: "wage" | "contract" | "community" | "safety" | "exit" | "contact" | "identity";
}

const INITIAL_NOTIFICATIONS: Notification[] = [
  {
    id: "1",
    title: "Wage Payment Alert",
    description: "Workers in Project Alpha have not received their wages for 2 weeks.",
    timestamp: "2 hours ago",
    isRead: false,
    type: "wage",
  },
  {
    id: "2",
    title: "Contract Review Required",
    description: "New contract for Project Beta requires your review.",
    timestamp: "5 hours ago",
    isRead: false,
    type: "contract",
  },
  {
    id: "3",
    title: "Community Feedback",
    description: "Community members have raised concerns about working conditions.",
    timestamp: "1 day ago",
    isRead: true,
    type: "community",
  },
  {
    id: "4",
    title: "Safety Incident Reported",
    description: "A safety incident has been reported at the construction site.",
    timestamp: "2 days ago",
    isRead: true,
    type: "safety",
  },
  {
    id: "5",
    title: "Worker Exit Interview",
    description: "3 workers have completed exit interviews.",
    timestamp: "3 days ago",
    isRead: true,
    type: "exit",
  },
  {
    id: "6",
    title: "Contact Information Updated",
    description: "New contact information has been added for Project Gamma.",
    timestamp: "4 days ago",
    isRead: true,
    type: "contact",
  },
  {
    id: "7",
    title: "Identity Verification Complete",
    description: "All workers for Project Delta have completed identity verification.",
    timestamp: "5 days ago",
    isRead: true,
    type: "identity",
  },
];

interface NotificationContextType {
  notifications: Notification[];
  unreadCount: number;
  markAsRead: (id: string) => void;
  deleteNotification: (id: string) => void;
  markAllAsRead: () => void;
}

const NotificationContext = createContext<NotificationContextType | undefined>(undefined);

export function NotificationProvider({ children }: { children: React.ReactNode }) {
  const [notifications, setNotifications] = useState<Notification[]>(() => {
    // Load from localStorage if available
    const saved = localStorage.getItem("anchor_notifications");
    return saved ? JSON.parse(saved) : INITIAL_NOTIFICATIONS;
  });

  // Save to localStorage whenever notifications change
  useEffect(() => {
    localStorage.setItem("anchor_notifications", JSON.stringify(notifications));
  }, [notifications]);

  const unreadCount = notifications.filter((n) => !n.isRead).length;

  const markAsRead = (id: string) => {
    setNotifications((prev) =>
      prev.map((n) => (n.id === id ? { ...n, isRead: true } : n))
    );
  };

  const deleteNotification = (id: string) => {
    setNotifications((prev) => prev.filter((n) => n.id !== id));
  };

  const markAllAsRead = () => {
    setNotifications((prev) => prev.map((n) => ({ ...n, isRead: true })));
  };

  return (
    <NotificationContext.Provider
      value={{
        notifications,
        unreadCount,
        markAsRead,
        deleteNotification,
        markAllAsRead,
      }}
    >
      {children}
    </NotificationContext.Provider>
  );
}

export function useNotifications() {
  const context = useContext(NotificationContext);
  if (!context) {
    throw new Error("useNotifications must be used within NotificationProvider");
  }
  return context;
}
