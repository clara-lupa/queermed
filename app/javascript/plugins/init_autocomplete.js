import places from 'places.js';

const initAutocomplete = () => {
  const addressInput = document.querySelector('.address-input');
  if (addressInput) {
    places({ container: addressInput });
  }
};

export { initAutocomplete };
