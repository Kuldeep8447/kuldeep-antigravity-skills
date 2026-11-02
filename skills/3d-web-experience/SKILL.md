---
name: 3d-web-experience
description: "Expert in building 3D experiences for the web - Three.js, React Three Fiber, Spline, WebGL, and interactive 3D scenes. Covers architectural 3D walkthroughs, 3D floor plan configurators, interactive residential towers, immersive websites, and WebGL optimization."
source: vibeship-spawner-skills (Apache 2.0)
---

# 3D Web Experience Architect

You bring the third dimension to the web. You know when 3D enhances and when it's just showing off. You balance visual impact with performance. You make 3D accessible to users who've never touched a 3D app. You create moments of wonder without sacrificing usability.

- Three.js implementation
- React Three Fiber (R3F)
- WebGL optimization
- 3D model integration (GLTF / GLB)
- Spline workflows
- 3D architectural models & floor plan configurators
- Interactive 3D scenes & building elevation tours
- 3D performance optimization & mobile fallback

---

## 1. 3D Stack Selection

### Options Comparison
| Tool | Best For | Learning Curve | Control |
|------|----------|----------------|---------|
| **Spline** | Quick prototypes, interactive 3D embeds | Low | Medium |
| **React Three Fiber (R3F)** | React apps, complex interactive scenes, architectural models | Medium | High |
| **Three.js vanilla** | Max control, standalone canvases | High | Maximum |
| **Babylon.js** | Heavy 3D, physics, complex lighting | High | Maximum |

### Decision Tree
```
Need quick 3D element / embed?
└── Yes → Spline
└── No → Continue

Using React?
└── Yes → React Three Fiber (@react-three/fiber + @react-three/drei)
└── No → Continue

Need max performance/control?
└── Yes → Three.js vanilla
└── No → Spline or R3F
```

### Spline Integration (Fastest Embed)
```jsx
import Spline from '@splinetool/react-spline';

export default function BuildingScene() {
  return (
    <div style={{ width: '100%', height: '500px' }}>
      <Spline scene="https://prod.spline.design/xxx/scene.splinecode" />
    </div>
  );
}
```

### React Three Fiber (Standard React WebGL)
```jsx
import React, { Suspense } from 'react';
import { Canvas } from '@react-three/fiber';
import { OrbitControls, useGLTF, Html, useProgress } from '@react-three/drei';

function Model({ url }) {
  const { scene } = useGLTF(url);
  return <primitive object={scene} scale={1.5} />;
}

function Loader() {
  const { progress } = useProgress();
  return <Html center><div className="loader">{progress.toFixed(0)}% loaded</div></Html>;
}

export default function Scene() {
  return (
    <Canvas camera={{ position: [0, 2, 5], fov: 45 }}>
      <ambientLight intensity={0.7} />
      <directionalLight position={[10, 10, 5]} intensity={1.2} />
      <Suspense fallback={<Loader />}>
        <Model url="/models/building-elevation.glb" />
      </Suspense>
      <OrbitControls enableZoom={true} maxPolarAngle={Math.PI / 2} />
    </Canvas>
  );
}
```

---

## 2. 3D Model Pipeline & Optimization

### Format Selection
| Format | Use Case | Size |
|--------|----------|------|
| **GLB / GLTF** | Standard web 3D (Recommended) | Smallest |
| **FBX** | Raw 3D software export | Large |
| **OBJ** | Simple static meshes | Medium |
| **USDZ** | Apple AR QuickLook (iOS) | Medium |

### Optimization Checklist
1. Model in Blender / 3ds Max / SketchUp
2. Reduce poly count (< 100K triangles for web performance)
3. Bake lighting and textures (combine draw calls into single atlas)
4. Export as `.glb` (binary GLTF)
5. Compress with Draco and WebP textures (`gltf-transform`)
6. Target total file size: **< 3MB - 5MB**

### GLTF Compression Commands
```bash
# Install gltf-transform CLI
npm install -g @gltf-transform/cli

# Optimize & compress model with Draco geometry & WebP textures
gltf-transform optimize input.glb output.glb \
  --compress draco \
  --texture-compress webp
```

---

## 3. Scroll-Driven 3D Experiences

### R3F + ScrollControls
```jsx
import React, { useRef } from 'react';
import { Canvas, useFrame } from '@react-three/fiber';
import { ScrollControls, useScroll } from '@react-three/drei';

function ScrollRotatingTower() {
  const scroll = useScroll();
  const towerRef = useRef();

  useFrame(() => {
    // Rotate model smoothly based on page scroll offset
    if (towerRef.current) {
      towerRef.current.rotation.y = scroll.offset * Math.PI * 2;
    }
  });

  return <primitive ref={towerRef} object={scene} />;
}

export default function InteractiveSection() {
  return (
    <div style={{ height: '100vh' }}>
      <Canvas>
        <ScrollControls pages={3} damping={0.25}>
          <ScrollRotatingTower />
        </ScrollControls>
      </Canvas>
    </div>
  );
}
```

---

## 4. Mobile & Low-End Device Guardrails

### ❌ What to Avoid:
1. **3D for 3D's sake**: Never use heavy 3D if a clean WebP / AVIF render or lightweight SVG gives better user clarity and speed.
2. **Desktop-only performance**: Test on real mid-range mobile devices (e.g. Android & iPhone).
3. **No Loading Skeleton**: Always provide a fallback progress bar or 2D image placeholder while assets load.
4. **Memory Leaks**: Dispose geometries, textures, and renderers on unmount.

### Mobile Fallback Strategy
```javascript
const isLowPowerDevice = () => {
  return /Android|iPhone|iPad/i.test(navigator.userAgent) || navigator.hardwareConcurrency < 4;
};
```
When low-power or mobile is detected:
* Reduce shadow map resolution (512x512 instead of 2048x2048).
* Disable post-processing bloom/SSAO.
* Lower `dpr` (device pixel ratio): `dpr={[1, 1.5]}` instead of `2`.
