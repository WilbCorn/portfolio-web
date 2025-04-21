<script>
    import { m } from '$lib/paraglide/messages.js';
  </script>
  
  <div class="min-w-screen flex items-start justify-center p-4">
    <div class="relative flex flex-col items-center w-full">
      
      <div class="flex flex-col items-center -mt-20">
        <div class="w-120 aspect-[3/4] relative mb-4">
          <!-- SVG Blob -->
          <div class="absolute inset-0 z-0">
            <svg id="sw-js-blob-svg" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg" class="w-260 h-280" style="position: absolute;top: 55%;left: 40%;transform: translate(-50%, -50%);">
              <defs>
                <linearGradient id="sw-gradient" x1="0" x2="1" y1="1" y2="0">
                  <stop id="stop1" stop-color="var(--secondary-accent)" offset="0%"></stop>
                  <stop id="stop2" stop-color="var(--primary-accent)" offset="100%"></stop>
                </linearGradient>
              </defs>
              <path fill="url(#sw-gradient)" 
              d="M24,-11.3C30.4,-2.8,34.4,9.6,29.9,17.4C25.5,
                25.2,12.8,28.3,2.6,26.8C-7.6,25.4,-15.3,19.3,
              -19.6,11.6C-23.9,3.8,-24.9,-5.5,-21.1,-12.5C-17.2,
              -19.5,-8.6,-24,0.1,-24.1C8.8,-24.2,17.6,-19.7,24,-11.3Z" 
              width="100%" 
              height="100%" 
              transform="translate(50 50)" 
              stroke-width="0" ></path>
            </svg>
          </div>
        
          <!-- Profile Image -->
          <img 
            src="/public/static/img/profile.png" 
            alt="Profile" 
            class="w-full h-full object-cover relative z-10"
          />
        </div>
        
        <div class="flex flex-col items-center space-y-4 text-center w-full 
                    bg-[var(--bg)] rounded-t-2xl p-6">
          <h2 class="text-2xl text-[var(--fg)]">{m.hero_subheading()}</h2>
          <h1 class="text-4xl font-bold text-[var(--fg)]">{m.hero_heading()}</h1>
          <p class="text-lg max-w-2xl text-[var(--fg)]">{m.hero_description()}</p>
        </div>
      </div>
    </div>
  </div>
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100" preserveAspectRatio="none">
  <path fill="var(--bg-secondary)" d="M0,64L80,58.7C160,53,320,43,480,53.3C640,64,800,96,960,96C1120,96,1280,64,1360,48L1440,32L1440,320L0,320Z"></path>
</svg>