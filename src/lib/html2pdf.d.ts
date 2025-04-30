declare module 'html2pdf.js' {
    const html2pdf: {
      (): {
        from: (element: HTMLElement | string) => {
          set: (options: Record<string, any>) => html2pdf;
          save: () => void;
        };
      };
    };
  
    export default html2pdf;
  }