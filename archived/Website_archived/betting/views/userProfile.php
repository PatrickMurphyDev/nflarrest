<?php
	require('views/components/logged_in_menu_header.php');

?>
<div class="five columns">

	<h4>Bets</h4>
	<ul id="betList">
	</ul>
</div>
<div class="four columns" style="margin-left:2vw;">
	<?php
switch($userDetails['user_group']){
	case 1:
		$userType = 'Member';
	break;
	case 2:
		$userType = 'Moderator';
	break;
	case 3:
		$userType = 'Admin';
	break;
}
	?>
	<h4><?php print $userDetails['user_name']; ?></h4>
	<p><?php print $userType . '<br/>Balance: $' .$userDetails['balance'].'<br />User Since: '.$userDetails['created']; ?></p>
</div>
<div class="seven columns offset-by-one" id="comments"></div>
<div id="place_bet_window" style="position:absolute;width:46%;left:25%;padding:2%;padding-top:0px; top:10%; border-radius:5px;background:#bfbfbf;display:none;"><h4 style="border-radius:3px;width:100%; height:25px; line-height:25px; background:#4b4b4b; color:#fff;">Place Bet</h4>
	Choose a crime, team or position that you think the next NFL arrest will involve. Select 2 or 3 Criteria and you will could have a bigger pay out! Click the <b>Switch Bet Type</b> button to predict how many more days we will go without arrest.<br/><br/>
	<style type="text/css">
		#betform {
			margin-bottom:0px;
		}
		#betform span {
			font-weight:bold;
		}
		#betform select {
			width:100%;
		}
		#betform input[type='number'] {
			width:100%;
		}
	</style>
	<form id="betform">
		<div class="row">
			<div id="switchBetButton" class="button six columns offset-by-three" style="background:#dfdfdf;">Switch Bet Type</div>
		</div>
		<div class="row">
			<div class="seven columns">
				<span>Bet Amount: </span>
					<br />
					<input type="number" name="amount" value="0" id="amount" />
					<br/>
				<div id="guessBetForm">
				<span>Crime: </span>
					<br />
					<select name="crime" id="crime_select">
						<option value="no-choice">No Bet</option>
						<?php echo $crime_options; ?>
					</select>
					<br/>
				<span>Team: </span>
					<br />
					<select name="team" id="team_select">
						<option value="no-choice">No Bet</option>
						<?php echo $team_options; ?>
					</select>
					<br/>
				<span>Position: </span>
					<br />
					<select name="position" id="pos_select">
						<option value="no-choice">No Bet</option>
						<?php echo $pos_options; ?>
					</select>
					<br/>
			</div>
			<div style="display:none;" id="recordBetForm">
			<p style="margin-bottom:2px">Predict no arrests in the next <span style="font-weight:bold;" id="dayCountText">X number of</span> days.</p>
			<!-- <select id="recordDate" name="recordDays">
			</select> -->
            <span># of days: </span>
					<br />
			<input type="number" min="0" value="0" id="recordDays" name="recordDays" />
			</div>
			</div>

			<div class="five columns">
			<span>Results: </span>
					<br />
				Odds: <span id="place_bet_odds">??</span><br/>
				You could win: <span id="pot_winning">$0</span><br/>
			</div>
		</div>
		<div class="row">
			<input class="button six columns" style="background-color:#fff;border-color:#7b7b7b;" id="place_bet_cancel_btn" type="reset" value="Cancel" onClick="hidePlaceBet()"/>
			<input type="submit" name="sumbit" class="button button-primary six columns" id="submit_bet" value="Place Bet!" />
		</div>
	</form>
</div>
<?php require('views/components/logged_in_footer.php'); ?>
<script src="js/comments.js" defer></script>
<script>
var crimeNames = <?php echo $crime_json; ?>;
var crimeOdds = <?php echo $crime_odds_json; ?>;
var teamNames = <?php echo $team_json; ?>;
	function loadBetList(){
		$('#betList').html('');
		$.getJSON('http://nflarrest.com/api/v1/bets/list?user_id=<?php echo $userDetails['user_id'];?>', function(data){
			if(data.length <= 0){
				$('#betList').html('<li><?php print $userDetails['user_name']; ?> Has no bets placed!</li>');
			}else{
				for(var key in data){
					var bet = data[key];
					var betTitle = "";
					var sep = "";
                    if(bet.recordDate > 0){
                        var tempDate = new Date(bet.recordDate*1000);
                        betTitle = 'no arrests until after <b>' + (tempDate.getMonth()+1)+'/'+tempDate.getDate()+'/'+tempDate.getFullYear() + '</b>';
                    }else{
                        if(bet.crime>0){
                            betTitle += "crime <b>"+crimeNames[bet.crime]+"</b>";
                            var sep = " and ";
                        }
                        if(bet.player !== "no-choice"){
                            betTitle += sep+"player <b>"+bet.player+"</b>";
                            var sep = " and ";
                        }
                        if(bet.team !== "no-choice"){
                            betTitle += sep+"team <b>"+teamNames[bet.team]+"</b>";
                            var sep = " and ";
                        }
                        if(bet.position !== "no-choice"){
                            betTitle += sep+"position <b>"+bet.position+"</b>";
                        }
                    }
					var prize = 0;
					if(bet.odds > 0){
						// odds are odds - 1
						prize = (bet.odds*bet.amount);
					}else{
						// odds are 1 - odds
						$tempOdds = (1/Math.abs(bet.odds))+1;
						prize = ($tempOdds * bet.amount);
					}
					$('#betList').append("<li><?php print $userDetails['user_name']; ?> bet <b>$"+bet.amount+"</b> on "+betTitle+" and could win <b>$"+prize+"</b></li>");
				}
			}
		});
	}
	var crimeNames = <?php echo $crime_json; ?>;
	var crimeOdds = <?php echo $crime_odds_json; ?>;
	var teamNames = <?php echo $team_json; ?>;
	var currCash = <?php echo $_SESSION['balance'];?>;
	function loadBetRecordDates(){
		$.getJSON('http://nflarrest.com/api/v1/meter', function(data){
			//$('#recordDate').append("<option>No Selection</option>");
			for(var key in data){
				var leader = data[key];
				$('#recordDate').append("<option>No Selection</option>");
			}
		});
	}
	var currBetType = true; // true == guess, false == record

	$('#switchBetButton').click(function(){
		currBetType = !currBetType;
		ga('send', 'event', 'betting', 'viewPlaceBetForm', 'switchType');
		if(currBetType){
			$('#guessBetForm').show();
			$('#recordBetForm').hide();
			// de select the record options

			$('#recordDays').val(0);
		}else{
			$('#guessBetForm').hide();
			$('#recordBetForm').show();
			$('#crime_select').val('no-choice');
			$('#team_select').val('no-choice');
			$('#pos_select').val('no-choice');
		}
		$('#place_bet_odds').html('??');
		$('#pot_winning').html('$'+($('#amount').val()));
	});

	function showPlaceBet(){
		//loadBetRecordDates();
		$('#place_bet_window').show();
        ga('send', 'event', 'betting', 'viewPlaceBetForm', 'showWindow');
	}

	function hidePlaceBet(){
		$('#place_bet_window').hide();
	}

	function calculateOdds(){
		if($('#amount').val() > currCash){
			$('#amount').val(currCash);
		}
		if($('#amount').val() <= 0){
			$('#amount').val(0);
		}
		if(currBetType){
			var odds = 1;
			if($('#crime_select').val() !== 'no-choice'){
				odds *= (14/1 + 1);
			}
			if($('#team_select').val() !== 'no-choice'){
				odds *= (32/1 + 1);
			}
			if($('#pos_select').val() !== 'no-choice'){
				odds *= (23/1 + 1);
			}
            if(odds == 1){
                odds = 0;
            }
			$('#place_bet_odds').html(odds + ' : 1');
			$('#pot_winning').html('$'+(odds * $('#amount').val()).toFixed(2));
		}else{
			var odds = 1;
			// calc record odds
			var days = $('#recordDays').val();
			if(days > 0){
			if (days > 7){
		            var prob = Math.exp(((days)*(0-1))/7.16);
		            odds = Math.floor(1/prob);
		            $('#place_bet_odds').html(odds + ' : 1');
		            $('#pot_winning').html('$'+(odds * $('#amount').val()).toFixed(2));
		         }else{
		            odds = 8-days; // 1 day = 1-7 odds, 7 days out = 1-1 odds
		            //tempOdds = 0 - tempOdds; // make negative for database storage
		            $('#place_bet_odds').html('1 : ' + odds);
		            $('#pot_winning').html('$'+(((1/odds)+1) * $('#amount').val()).toFixed(2));
		         }
		         }else{
		            $('#place_bet_odds').html('??');
		            $('#pot_winning').html('$0.00');
		         }

		}


	}
	$(document).ready(function(){
		$('#amount').change(calculateOdds);
		$('#crime_select').change(calculateOdds);
		$('#team_select').change(calculateOdds);
		$('#pos_select').change(calculateOdds);
		$('#recordDays').change(function(){
            $('#dayCountText').html($('#recordDays').val());
            calculateOdds();
        });
		$('#betform').submit(function(e){
			e.preventDefault();
			function handle_response(resp){
				resp = $.parseJSON(resp);
				if(resp.submit == true){
					alert('bet placed');
					currCash -= $('#amount').val();
					hidePlaceBet();
					loadBetList();
                    ga('send', 'event', 'betting', 'placeBet', $('#amount').val());
				}else{
					alert('Bet could not be placed. Error: ' + resp.error);
				}
			}
			if($('#amount').val() > 0){
				if(currBetType){
					$.post('http://nflarrest.com/api/v1/bets/placeBet', {'amount':$('#amount').val(), 'crime':$('#crime_select').val(), 'team':$('#team_select').val(), 'position': $('#pos_select').val(), 'player':'no-choice'}, handle_response);
				}else{
					$.post('http://nflarrest.com/api/v1/bets/placeBet', {'amount':$('#amount').val(), 'recordDays':$('#recordDays').val()}, handle_response);
				}
			}else{
				alert('You did not wager any money!');
			}
		});
		loadBetList();
	});
</script>
