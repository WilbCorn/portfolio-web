<script>
    export let title = '';
    let isHovered = false;
    let x = 0;
    let y = 0;
  
    let hoverTimeout; // To handle the delay
  
    function mouseOver(event) {
      // Clear any existing timeout to avoid multiple triggers
      clearTimeout(hoverTimeout);
  
      // Set a timeout to delay showing the tooltip
      hoverTimeout = setTimeout(() => {
        isHovered = true;
        updateTooltipPosition(event);
      }, 500); // 500ms delay
    }
  
    function mouseMove(event) {
      if (isHovered) {
        updateTooltipPosition(event);
      }
    }
  
    function mouseLeave() {
      // Clear the timeout if the user moves away before the delay ends
      clearTimeout(hoverTimeout);
  
      // Immediately hide the tooltip
      isHovered = false;
    }
  
    function updateTooltipPosition(event) {
      const tooltipWidth = 150; // Approximate width of the tooltip
      const tooltipHeight = 30; // Approximate height of the tooltip
      const offset = 10; // Offset from the cursor
  
      // Get the current viewport dimensions
      const viewportWidth = window.innerWidth;
      const viewportHeight = window.innerHeight;
  
      // Calculate the tooltip position
      let newX = event.pageX + offset;
      let newY = event.pageY + offset;
  
      // Ensure the tooltip does not go outside the viewport
      if (newX + tooltipWidth > viewportWidth) {
        newX = event.pageX - tooltipWidth - offset; // Move tooltip to the left of the cursor
      }
      if (newY + tooltipHeight > viewportHeight) {
        newY = event.pageY - tooltipHeight - offset; // Move tooltip above the cursor
      }
  
      // Clamp the tooltip position to the viewport edges
      if (newX < 0) {
        newX = 0; // Clamp to the left edge
      }
      if (newY < 0) {
        newY = 0; // Clamp to the top edge
      }
  
      // Update the position
      x = newX;
      y = newY;
    }
  </script>
  
  <!-- Tooltip Trigger -->
  <div
    class="relative inline-block"
    on:mouseover={mouseOver}
    on:mouseleave={mouseLeave}
    on:mousemove={mouseMove}>
    <slot />
  </div>
  
  {#if isHovered}
    <div style="top: {y}px; left: {x}px;" class="tooltip text-[var(--primary-accent)]">
      {title}
    </div>
  {/if}
  
  <style>
    .tooltip {
      position: absolute; /* Take the tooltip out of the document flow */
      z-index: 1000; /* Ensure the tooltip is above other elements */
      border: 1px solid #ddd;
      box-shadow: 1px 1px 1px #ddd;
      background: white;
      border-radius: 4px;
      padding: 4px;
      white-space: nowrap; /* Prevent text wrapping */
      pointer-events: none; /* Make the tooltip non-interactive */
      transition: opacity 0.2s ease-in-out; /* Smooth fade-in/out */
    }
  
    /* Optional: Add styling to the wrapper */
    .relative {
      display: inline-block; /* Ensure the wrapper only takes up as much space as its content */
    }
  </style>