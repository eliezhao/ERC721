import ERC721 from 'ic:canisters/ERC721';

ERC721.greet(window.prompt("Enter your name:")).then(greeting => {
  window.alert(greeting);
});
