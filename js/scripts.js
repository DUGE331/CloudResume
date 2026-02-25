/*!
* Start Bootstrap - Resume v7.0.6
* Licensed under MIT
*/

window.addEventListener('DOMContentLoaded', event => {

    // Activate Bootstrap scrollspy
    const sideNav = document.body.querySelector('#sideNav');
    if (sideNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#sideNav',
            rootMargin: '0px 0px -40%',
        });
    }

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = Array.from(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.forEach(item => {
        item.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

    // --- Visitor Counter ---
    // --- Visitor Counter ---
const apiUrl = "https://p1i6f6qtq9.execute-api.ap-southeast-2.amazonaws.com/Prod/visitor";


    async function updateVisitorCount() {
        try {
            const response = await fetch(apiUrl); // GET increments counter
            const data = await response.json();
            const counter = document.getElementById("counter");
            if (counter) {
                counter.innerText = data.visitor_count; // match your API response
            }
        } catch (err) {
            console.error("Visitor counter error:", err);
            const counter = document.getElementById("counter");
            if (counter) counter.innerText = "error";
        }
    }

    updateVisitorCount();

});

window.addEventListener('DOMContentLoaded', updateVisitorCount);