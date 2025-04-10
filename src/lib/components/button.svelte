<script lang="ts">
    import type { Snippet } from 'svelte';
    import type { HTMLButtonAttributes } from 'svelte/elements';
   
    type ButtonProps = {
      children: Snippet;
    } & HTMLButtonAttributes;
   
    let { children, ...restProps }: ButtonProps = $props();
  </script>
   
  <button class="btn" {...restProps}>
    {@render children()}
  </button>
   
  <style>
    :global(.light) {
      color-scheme: light;
      --btn-bg: red;
      --btn-fg: white;
    }
   
    :global(.dark) {
      color-scheme: dark;
      --btn-bg: blue;
      --btn-fg: white;
    }
   
    .btn {
      background-color: var(--btn-bg);
      color: var(--btn-fg)
      display: inline-flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
    }
  </style>