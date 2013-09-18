<%-- Copyright (c) 2013 NuoDB, Inc. --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags"%>

<t:page showHeader="false">
    <div id="control-panel">
        <!-- Top nav -->
        <div id="top-bar" class="navbar">
            <label>NuoDB Storefront Demo &mdash; Control Panel</label>
            <div class="navbar-inner">
                <ul class="nav pull-right">
                    <li><div><a id="btn-refresh" class="btn btn-success" href="#"><i class="icon icon-refresh icon-white"></i> Refresh</a></div></li>
                    <t:admin-link />
                </ul>
            </div>
        </div>

        <t:messages />
        
        <!-- Workload controls -->
        <div id="regions"></div>
        <script id="tpl-regions" type="text/template">    
			{{#result}}
				<table class="table table-bordered" id="table-regions">
					<col width="200" />
					<col width="100" />
					<col width="155" />
					<col  />
					<col width="50" />
					<col width="110" />					
					<thead>
						<tr>
							<th colspan="3">
								<h3>Regions</h3>
								<h4>{{regionSummaryLabel}}:</h4>
								<ul class="nav">
									<li><span id="label-active" class="label label-success">0</span> Active</li>
									<li><span id="label-heavy-load" class="label label-warning">0</span> Under heavy load</li>
									<li><span id="label-not-responding" class="label label-important">0</span> Not responding</li>
								</ul>
							</th>
							<th colspan="3" class="customer-summary">
								<h3>Customers</h3>

								<h4><span id="summary-users-simulated">0 simulated users</span>: <button class="pull-right btn btn-danger btn-small" id="btn-reset" title="Sets the number of user to 0 across all workloads">Stop All</button></h4>
								<ul class="nav">
									{{#workloads}}
										<li><span data-workload="{{workload.name}}" class="label label-color-{{@index}}">0</span> Simulated {{lowerCaseFormat workload.name}}</li>
									{{/workloads}}
								</ul>
								
								<h4><span id="summary-users-real">0 real users</span>:</h4>
								<ul class="nav">
									<li id="label-web-user-count"><span class="label label-real">0</span> Web browser user</li>
								</ul>
							</th>
						</tr>
					</thead>
					<tbody>
						{{#regions}}
							<tr class="region-overview" data-region="{{regionName}}">
								<td>
									<div class="dropdown">
										<a href="#" data-toggle="dropdown"><span class="label label-status label-refreshing"><img class="invisible" src="img/refreshing.gif" width="16" height="16" title="Refreshing..." /></span> {{regionName}}<b class="caret"></b></a>
										<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
    										{{#instances}}
	        									<li>
													<a tabindex="-1" href="{{url}}" target="_blank" data-instance="{{uuid}}"><span class="label label-status label-refreshing"><img class="invisible" src="img/refreshing.gif" width="16" height="16" title="Refreshing..." /></span> {{url}}</a>
												</li>
    										{{/instances}}
										</ul>
									</div>									
								</td>
								<td class="lbl-instances">{{instanceCountLabel}}</td>
								<td class="currency">
									<div class="btn-group">
										<a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span>{{currencyFormat currency}}</span> <b class="caret"></b></a>
										<ul class="dropdown-menu pull-right">
											<li><a tabindex="-1" href="#" data-currency="US_DOLLAR">U.S. dollar ($)</a></li>
											<li><a tabindex="-1" href="#" data-currency="BRITISH_POUND">British pound (£)</a></li>
											<li><a tabindex="-1" href="#" data-currency="EURO">Euro (€)</a></li>
										</ul>
									</div>
								</td>                    
								<td>
									<div class="progress">
										{{#workloads}}
											<div class="bar label-color-{{@index}}" style="width: 0%;" title="{{workload.name}}"></div>
										{{/workloads}}
										<div class="bar label-color-real" style="width: 0%;" title="Web browser user"></div>
									</div>
								</td>
								<td class="lbl-users">0</td>
								<td class="controls">
									<button class="btn btn-change">Change <b class="caret"></b></button>
									<button class="btn dropup btn-hide hide">Hide <b class="caret"></b></button>
								</td>
							</tr>
							<tr class="region-details hide active" data-region="{{regionName}}">
								<td colspan="6">
									<div class="details-box">
										<table class="table table-hover table-bordered table-condensed">
											<col />
											<col width="321" />
											<col width="50" />
											<col width="98" />
											<thead>
												<tr>
													<th>Simulated workload:</th>
													<th colspan="2">Current users:</th>
													<th class="users">Change to:</th>
												</tr>
											</thead>
											<tbody>
												{{#workloads}}
													<tr>
														<td><span class="label label-color-{{@index}}">&nbsp;</span> {{workload.name}}</td>
														<td>
															<div class="progress">
																<div class="bar empty" style="width: 10%;"></div>
																<div class="bar label-color-{{@index}}" style="width: 10%;" title="{{workload.name}}"></div>
															</div>
														</td>
														<td class="lbl-users">0</td>
														<td class="users">
															{{#if workload.avgThinkTimeMs}}
																<input class="input-mini" type="number" name="workload-{{workload.name}}" data-name="{{workload.name}}" value="{{numberOrZero activeWorkerLimit}}" min="0" {{#if workload.maxWorkers}}max="{{workload.maxWorkers}}"{{/if}} step="1" />
															{{else}}
																<input readonly="readonly" title="Workloads with 0 are for benchmark running only and cannot be modified here.  This helps keep the Storefront responsive." class="input-mini" type="number" name="workload-{{workload.name}}" value="{{numberOrZero activeWorkerLimit}}" min="0" max="1000" step="1" />
															{{/if}}
														</td>
													</tr>
												{{/workloads}}
											</tbody>
											<tfoot>
												<tr>
													<td></td>
													<td colspan="3" class="users">
														<button class="btn btn-primary" type="submit">Update Workloads</button>
													</td>
												</tr>
											</tfoot>
										</table>
									</div>
								</td>
							</tr>
						{{/regions}}         
					</tbody>
				</table>
			{{/result}}
		</script>
    
        <div id="product-info"></div>        
        <script id="tpl-product-info" type="text/template">
			{{#result}}
				{{#if hasData}}
       	            <hr />
                	<form method="post" id="product-info">
                    	<h2 id="data-summary">Product Catalog</h2>
    	                <p>There are currently {{numberFormat productCount}} products across {{numberFormat categoryCount}} categories.</p>
	                    <p><button class="btn btn-danger" name="btn-msg" type="submit" value="Remove All Data">Remove All Data</button>
                	</form>
				{{/if}}
			{{/result}}
		</script>
        
        <hr />
        <h2 id="workload-sec">Node Setup</h2>
        <p>To add nodes to your NuoDB cluster, use the NuoDB Console.</p>
        <p>If you are running NuoDB locally with default settings, you will find the Console at <a href="http://localhost:8080/" target="_blank">http://localhost:8080/</a>.</p>
    </div>
    
    <div class="footer">Copyright &copy; 2013 NuoDB, Inc. All rights reserved.</div>
</t:page>
