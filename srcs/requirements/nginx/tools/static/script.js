const contactLinkItemEl = document.getElementsByClassName('contact-link-item')
const addressEl = document.getElementById('address')

Array.from(contactLinkItemEl).forEach(el => {
  el.addEventListener('mouseover', () => {
    addressEl.style.color = 'var(--font-color-primary)'
  })
  el.addEventListener('mouseout', () => {
    addressEl.style.color = 'var(--font-color-secondary)'
  })
  
});
