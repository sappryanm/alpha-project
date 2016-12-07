 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:import url="/WEB-INF/jsp/header.jsp" />

<h2>Welcome to Landmark Tours</h2>

<h3> Please Select Your Hotel as a Starting point</h3>

<script type="text/javascript">
    var mile = ['1 Mile','2 Miles','10 Miles','25 Miles'];
    var type = ['Entertainment','Sports', 'Shopping'];
    function setSelect(v) {
        var x = document.getElementById("Miles");
        for (i = 0; i < x.length; ++i) { 
            x.remove(x.length -1);
        }
        var a;
        if (v=='miledd'){
            a = bedrooms;
        } else if (v=='typedd'){
            a = offices
        }
        for (i = 0; i < a.length; ++i) {
            var option = document.createElement("option");
            option.text = a[i];
            x.add(option);
        }
    }
    function load() {
        setSelect('milesdd');
    }
    window.onload = load;

</script>
<input type="radio" name="bb" value="milesearch"   onclick="setSelect('milesdd')" checked > Radius Search <br>
<input type="radio" name="bb" value="typesearch" onclick="setSelect('typedd')" > Type Search <br>
<label>Size</label>
<select name="bedroom" id="bedroom" style="color: #8E9092; /*height: 38px;width: 228px;*/"  >
</select>
<form method="POST" action="${formAction}">
	<div class="row">
		<div class="col-sm-6">	
			<div class="form-search">

				<table>
					<tr>
						<td class="entry">
						</td>
						<td class="entry">
							<input type="radio" id="distance" name="chk" value="1" checked>Distance <br/>
							<input type="radio" id="type" name="chk" value="2" >Type<br/>
							<br/>
						
						<select id="describe">
							<option name="name" value="1">Select from above</option>
						</select>
						
                <input type="submit" value="Submit" name="submit" />
            </td>
        </tr>
        <tr>

        </tr>
    </table>
</form>

<!-- 				<label for="statingPoint">Hotel: </label></br>
					<input type="radio" id="Courtyard Columbus Downtown" name="startingPoint">Courtyard Columbus Downtown</input></br>
					<input type="radio" id="Homewood Suites by Hilton Polaris" name="startingPoint" />Homewood Suites by Hilton Polaris</input></br>
					<input type="radio" id="The Blackwell" name="startingPoint" />The Blackwell</input></br>
					<input type="radio" id="Hampton Inn & Suites University Area" name="startingPoint" />Hampton Inn & Suites University Area</input></br>
					<input type="radio" id="Drury Inn & Suites Columbus Convention Center" name="startingPoint" />Drury Inn & Suites Columbus Convention Center</input></br>
					</br> -->
				
			</div>
			
			<button type="submit" class="btn btn-default">Enter Starting Point</button>
			<p> Then Use google APi </p>
		</div>
		

</form>
<div><p> Stuff we need to implement
origin: New York, NY
destination: Boston, MA
waypoints: optimize:true|Providence, RI|Hartford, CT
mode: driving
key: AIzaSyAr5ShZL1BRiM_fdvx6wHIKpe48McMYqb8
</p>
</div>
<form NAME="roundtrip" METHOD="get" ACTION="http://gebweb.net/optimap/index.php">
<input NAME="loc0" TYPE="text" VALUE="39.965741,	-83.002793"/>
<input NAME="loc1" TYPE="text" VALUE="39.965849,	-82.953303" />
<input NAME="loc2" TYPE="text" VALUE="39.956723,	-83.003568" />
<input NAME="loc3" TYPE="text" VALUE="39.969817,	-83.010041" />
<input TYPE="submit" TYPE="text" VALUE="Submit" />
</form>
		
<c:import url="/WEB-INF/jsp/footer.jsp" />
		