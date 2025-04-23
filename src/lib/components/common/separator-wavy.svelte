<script>
    // Define a prop for the fill color
    export let color = "var(--bg-secondary)"; // Default color
    export let spacing = "0"; // Default spacing
  </script>
  
  <!-- Wavy Line SVG -->
  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100" preserveAspectRatio="none" class="w-full">
    <path
      fill={color}
      d="M0,64L80,58.7C160,53,320,43,480,53.3C640,64,800,96,960,96C1120,96,1280,64,1360,48L1440,32L1440,320L0,320Z"
    ></path>
  </svg>
  <div style={`height: ${spacing}px; background-color: ${color};`}></div>