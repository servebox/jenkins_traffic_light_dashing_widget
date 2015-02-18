##Preview

![](https://raw.githubusercontent.com/servebox/jenkins_traffic_light_dashing_widget/master/screenshot.png)

## Description

Simple [Dashing](http://shopify.github.com/dashing) widget to display the status of Jenkins' Continuous Integration jobs as a traffic light. This widget is based on [the Roxanne gem](https://github.com/servebox/roxanne).

##Usage

To use this widget, copy `jenkins_traffic_light.html`, `jenkins_traffic_light.coffee`, and `jenkins_traffic_light.scss` into the `/widgets/jenkins_traffic_light` directory. Put the `jenkins_traffic_light.rb` file in your `/jobs` folder.

To include the widget in a dashboard, add the following snippet to the dashboard layout file:

<li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
<div data-id="jenkins" data-view="JenkinsTrafficLight"></div>
</li>

##Settings

You'll need to change the following values in the `jenkins_traffic_light.rb` file: `JENKINS_HOST`, `PATH`, `USERNAME`, `PASSWORD`, `SSL_ENABLED` and `PORT`.

##References

Based on [Roxanne](https://github.com/servebox/roxanne).

CSS inspired by: [http://codepen.io/abruzzi/pen/cEfGi](http://codepen.io/abruzzi/pen/cEfGi).
