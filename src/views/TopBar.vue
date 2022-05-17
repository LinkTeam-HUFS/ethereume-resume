<template>
  <header class="app--header">
    <div class="ui container1 app--navigation">
      <nav class="ui grid">
        <div class="row">
          <a aria-current="page" class="app--logo" href="/">
            <div class=" gatsby-image-wrapper" style="position:relative;overflow:hidden;display:inline-block;width:142px;height:45px"> 
              <img aria-hidden="true" :src="require('../img/title.png')" alt="연결고리" style="position: absolute; top: 0px; left: 0px; width: 100%; height: 100%; object-fit: cover; object-position: center center; transition-delay: 500ms;"/>
            </div>
          </a>

          <ul class="app--navbar reset-list un-select">
            <li>
              <a href="/">Main</a>
            </li>
            <li>
              <a href="/">Profile</a>
            </li>
            <li>
              <a href="/">Example</a>
            </li>
            
          </ul>

        </div>
      </nav>
    </div>
  </header>
</template>

<style>

  header{
    display: block;
  }

  .ui.container1 {
    margin-left: auto!important;
    margin-right: auto!important;
    width: 723px;
}

.ui.grid {
    align-items: stretch;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    margin: -1rem;
    padding: 0;
}

.app--navigation .ui.grid {
    margin: 0;
}

.ui.grid>.row {
    align-items: stretch;
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: inherit;
    padding: 1rem 0;
    position: relative;
    width: 100%!important;
}

.app--navigation .app--logo {
    flex: 1 1 auto;
    line-height: 1;
    margin-right: 8cm;
}

a, a:hover {
    text-decoration: none;
}

a {
    color: #ff63c3;
}

.app--navigation ul.app--navbar {
    flex: 1 1 auto;
    height: 45px;
    margin: 0.25cm;
    padding-left: 0;
    text-align: right;
    
}
.app--navigation ul.app--navbar li {
    display: inline-block;
    font-size: 1rem;
    margin-right: 18px;
}

ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}

.gatsby-image-wrapper:after {
    box-shadow: inset 0 0 1px 0 #fff;
    content: "";
    display: block;
    height: 100%;
    position: absolute;
    top: 0;
    width: 100%;
}



</style>