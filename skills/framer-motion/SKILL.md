---
name: framer-motion
description: Master modern Framer Motion and Motion.dev (motion/react) animation patterns for React and Next.js. Covers declarative animations, calibrated spring physics presets, stagger orchestration, layout animations with layoutId, AnimatePresence exit animations, scroll-linked effects with useScroll/useTransform, gesture interactions, accessibility (useReducedMotion), and hardware acceleration.
metadata:
  version: "1.0.0"
---

# Framer Motion & Motion (motion/react) Skill

This skill provides expert patterns, calibrated presets, and production-ready recipes for building fluid, physics-driven animations with **Framer Motion** and **Motion** (`motion/react`) in React, Next.js, and modern frontend stacks.

---

## 1. Package Selection & Imports

### Modern Motion (Recommended for new projects)
```bash
npm install motion
```
```tsx
import { motion, AnimatePresence, useScroll, useTransform, useReducedMotion } from "motion/react";
```

### Classic Framer Motion
```bash
npm install framer-motion
```
```tsx
import { motion, AnimatePresence, useScroll, useTransform, useReducedMotion } from "framer-motion";
```

> **Next.js App Router Note**: Any component using `motion`, `useScroll`, or event handlers must be a Client Component:
> ```tsx
> "use client";
> ```

---

## 2. Calibrated Physics & Spring Presets

Avoid arbitrary numbers. Use these standard calibrated physics tokens:

```typescript
export const transitions = {
  // Snappy: Buttons, toggles, quick tooltips, active states
  snap: {
    type: "spring",
    stiffness: 500,
    damping: 30,
    mass: 0.8,
  },

  // Smooth / Silk: Modals, dropdown menus, sheet drawers, route transitions
  smooth: {
    type: "spring",
    stiffness: 260,
    damping: 24,
  },

  // Bouncy: Likes, confetti, playful badges, success checkmarks
  bouncy: {
    type: "spring",
    stiffness: 400,
    damping: 15,
  },

  // Gentle / Float: Ambient floating elements, large cards, lazy reveals
  gentle: {
    type: "spring",
    stiffness: 120,
    damping: 18,
    mass: 1.2,
  },

  // Stiff: Rapid keyboard navigation focus indicators, slider thumbs
  stiff: {
    type: "spring",
    stiffness: 700,
    damping: 35,
  },
} as const;
```

---

## 3. Core Motion Primitives

### Basic Element Animation
```tsx
<motion.div
  initial={{ opacity: 0, y: 16 }}
  animate={{ opacity: 1, y: 0 }}
  exit={{ opacity: 0, y: -16 }}
  transition={transitions.smooth}
>
  Content
</motion.div>
```

### Micro-interactions & Gestures
```tsx
<motion.button
  whileHover={{ scale: 1.03, y: -2 }}
  whileTap={{ scale: 0.97 }}
  whileFocus={{ outline: "2px solid var(--primary)" }}
  transition={transitions.snap}
>
  Click Me
</motion.button>
```

---

## 4. Orchestration & Variants

Use `variants` to cleanly decouple animation definitions and coordinate child elements:

```tsx
const containerVariants = {
  hidden: { opacity: 0 },
  visible: {
    opacity: 1,
    transition: {
      staggerChildren: 0.08,
      delayChildren: 0.1,
    },
  },
  exit: {
    opacity: 0,
    transition: {
      staggerChildren: 0.04,
      staggerDirection: -1,
    },
  },
};

const itemVariants = {
  hidden: { opacity: 0, y: 20 },
  visible: {
    opacity: 1,
    y: 0,
    transition: transitions.smooth,
  },
  exit: {
    opacity: 0,
    y: -10,
    transition: { duration: 0.2 },
  },
};

export function StaggeredList({ items }: { items: string[] }) {
  return (
    <motion.ul
      variants={containerVariants}
      initial="hidden"
      animate="visible"
      exit="exit"
    >
      {items.map((item) => (
        <motion.li key={item} variants={itemVariants}>
          {item}
        </motion.li>
      ))}
    </motion.ul>
  );
}
```

---

## 5. Exit Animations with `AnimatePresence`

`AnimatePresence` enables exit animations when components are unmounted.

### Key Rules:
1. Direct children of `AnimatePresence` **must** have a unique `key`.
2. Use `mode="wait"` when swapping views (wait for exit before entering next).
3. Use `mode="popLayout"` for lists to prevent sudden layout jumps when items are deleted.

```tsx
<AnimatePresence mode="wait">
  {isOpen && (
    <motion.div
      key="modal-backdrop"
      initial={{ opacity: 0 }}
      animate={{ opacity: 1 }}
      exit={{ opacity: 0 }}
      className="fixed inset-0 bg-black/60 backdrop-blur-sm"
    >
      <motion.div
        key="modal-content"
        initial={{ opacity: 0, scale: 0.95, y: 20 }}
        animate={{ opacity: 1, scale: 1, y: 0 }}
        exit={{ opacity: 0, scale: 0.95, y: 15 }}
        transition={transitions.smooth}
        className="modal-box"
      >
        <h2>Dialog Title</h2>
      </motion.div>
    </motion.div>
  )}
</AnimatePresence>
```

---

## 6. Layout Animations & Shared Transitions (`layoutId`)

Framer Motion automatically calculates FLIP (First, Last, Invert, Play) animations when layouts change.

### Zero-Jank Sliding Active Pill (e.g., Navigation Tabs)
```tsx
export function Tabs({ tabs, activeTab, onSelect }: TabsProps) {
  return (
    <div className="flex gap-2 p-1 bg-neutral-100 rounded-xl relative">
      {tabs.map((tab) => {
        const isActive = activeTab === tab.id;
        return (
          <button
            key={tab.id}
            onClick={() => onSelect(tab.id)}
            className="relative px-4 py-2 text-sm font-medium transition-colors z-10"
          >
            {isActive && (
              <motion.div
                layoutId="active-pill"
                className="absolute inset-0 bg-white rounded-lg shadow-sm -z-10"
                transition={transitions.snap}
              />
            )}
            {tab.label}
          </button>
        );
      })}
    </div>
  );
}
```

### Shared Card Expansion
```tsx
// Card in list
<motion.div layoutId={`card-${card.id}`} onClick={() => setSelected(card)}>
  <motion.h3 layoutId={`title-${card.id}`}>{card.title}</motion.h3>
</motion.div>

// Expanded card in modal
<motion.div layoutId={`card-${selected.id}`} className="expanded-view">
  <motion.h3 layoutId={`title-${selected.id}`}>{selected.title}</motion.h3>
  <p>{selected.fullDescription}</p>
</motion.div>
```

---

## 7. Scroll-Linked Animations (`useScroll`, `useTransform`)

### Scroll Progress Indicator
```tsx
export function ScrollProgress() {
  const { scrollYProgress } = useScroll();
  const scaleX = useSpring(scrollYProgress, transitions.smooth);

  return (
    <motion.div
      style={{ scaleX }}
      className="fixed top-0 left-0 right-0 h-1 bg-gradient-to-r from-blue-500 to-indigo-600 origin-left z-50"
    />
  );
}
```

### Parallax & Fade-on-Scroll
```tsx
export function ParallaxHero() {
  const ref = useRef(null);
  const { scrollYProgress } = useScroll({
    target: ref,
    offset: ["start start", "end start"],
  });

  const y = useTransform(scrollYProgress, [0, 1], ["0%", "40%"]);
  const opacity = useTransform(scrollYProgress, [0, 0.8], [1, 0]);

  return (
    <div ref={ref} className="relative h-screen overflow-hidden">
      <motion.div style={{ y, opacity }} className="absolute inset-0">
        <HeroContent />
      </motion.div>
    </div>
  );
}
```

---

## 8. Accessibility & Reduced Motion

Always respect user accessibility settings (`prefers-reduced-motion`):

```tsx
export function AccessibleAnimation({ children }: { children: React.ReactNode }) {
  const shouldReduceMotion = useReducedMotion();

  return (
    <motion.div
      initial={{ opacity: 0, y: shouldReduceMotion ? 0 : 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ duration: shouldReduceMotion ? 0.01 : 0.35 }}
    >
      {children}
    </motion.div>
  );
}
```

---

## 9. Performance Best Practices

1. **Only Animate GPU-Accelerated Properties**:
   - ✅ Animate `transform` (via `x`, `y`, `scale`, `rotate`) and `opacity`.
   - ❌ Avoid animating `width`, `height`, `top`, `left`, `margin`, or `padding` directly (use `layout` prop instead).
2. **Use `layout="position"`** when only the element's position changes and its size remains constant to avoid unnecessary SVG/text scaling passes.
3. **Add `willChange` dynamically**:
   - Framer Motion manages `will-change` during active animations automatically, but for large composite layers, set `style={{ willChange: "transform, opacity" }}`.
