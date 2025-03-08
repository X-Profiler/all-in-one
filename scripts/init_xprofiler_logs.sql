-- xprofiler_logs

-- template: `process_${MM-DD}`
CREATE TABLE IF NOT EXISTS `process`(
  `id` INT UNSIGNED AUTO_INCREMENT COMMENT 'unique auto increment id',
  `app` INT NOT NULL COMMENT 'app id',
  `agent` VARCHAR(50) NOT NULL COMMENT 'agent name',
  `pid` INT NOT NULL COMMENT 'process id',
  `uptime` INT UNSIGNED COMMENT 'process uptime (sec)',
  `log_time` DATETIME NOT NULL COMMENT 'process log created time on agent',
  `version` VARCHAR(50) NOT NULL COMMENT 'xprofiler version',

  -- cpu
  `cpu_now` DECIMAL(5,2) COMMENT 'current process cpu usage (0-100%)',
  `cpu_15` DECIMAL(5,2) COMMENT 'process cpu usage in last 15 sec (0-100%)',
  `cpu_30` DECIMAL(5,2) COMMENT 'process cpu usage in last 30 sec (0-100%)',
  `cpu_60` DECIMAL(5,2) COMMENT 'process cpu usage in last 60 sec (0-100%)',

  -- memory
  -- overview
  `rss` BIGINT COMMENT 'resident set size (byte)',
  `heap_used` BIGINT UNSIGNED COMMENT 'heap used (byte)',
  `heap_available` BIGINT UNSIGNED COMMENT 'heap available (byte)',
  `heap_total` BIGINT UNSIGNED COMMENT 'heap total (byte)',
  `heap_limit` BIGINT UNSIGNED COMMENT 'heap limit (byte)',
  `heap_executeable` BIGINT UNSIGNED COMMENT 'heap executeable (byte)',
  `total_physical_size` BIGINT UNSIGNED COMMENT 'heap executeable (byte)',
  `malloced_memory` BIGINT UNSIGNED COMMENT 'malloced memory (byte)',
  `amount_of_external_allocated_memory` BIGINT UNSIGNED COMMENT 'external allocated memory (byte)',
  -- new space size
  `new_space_size` BIGINT UNSIGNED COMMENT 'new space total (byte)',
  `new_space_used` BIGINT UNSIGNED COMMENT 'new space used (byte)',
  `new_space_available` BIGINT UNSIGNED COMMENT 'new space available (byte)',
  `new_space_committed` BIGINT UNSIGNED COMMENT 'new space actually applies for physical memory (byte)',
  -- old space size
  `old_space_size` BIGINT UNSIGNED COMMENT 'old space total (byte)',
  `old_space_used` BIGINT UNSIGNED COMMENT 'old space used (byte)',
  `old_space_available` BIGINT UNSIGNED COMMENT 'old space available (byte)',
  `old_space_committed` BIGINT UNSIGNED COMMENT 'old space actually applies for physical memory (byte)',
  -- code space size
  `code_space_size` BIGINT UNSIGNED COMMENT 'code space total (byte)',
  `code_space_used` BIGINT UNSIGNED COMMENT 'code space used (byte)',
  `code_space_available` BIGINT UNSIGNED COMMENT 'code space available (byte)',
  `code_space_committed` BIGINT UNSIGNED COMMENT 'code space actually applies for physical memory (byte)',
  -- map space size
  `map_space_size` BIGINT UNSIGNED COMMENT 'hidden class space total (byte)',
  `map_space_used` BIGINT UNSIGNED COMMENT 'hidden class space used (byte)',
  `map_space_available` BIGINT UNSIGNED COMMENT 'hidden class space available (byte)',
  `map_space_committed` BIGINT UNSIGNED COMMENT 'hidden class space actually applies for physical memory (byte)',
  -- large object space size
  `lo_space_size` BIGINT UNSIGNED COMMENT 'large object space total (byte)',
  `lo_space_used` BIGINT UNSIGNED COMMENT 'large object space used (byte)',
  `lo_space_available` BIGINT UNSIGNED COMMENT 'large object space available (byte)',
  `lo_space_committed` BIGINT UNSIGNED COMMENT 'large object space actually applies for physical memory (byte)',
  -- read only space size
  `read_only_space_size` BIGINT UNSIGNED COMMENT 'read only space total (byte)',
  `read_only_space_used` BIGINT UNSIGNED COMMENT 'read only space used (byte)',
  `read_only_space_available` BIGINT UNSIGNED COMMENT 'read onlyread only space available (byte)',
  `read_only_space_committed` BIGINT UNSIGNED COMMENT 'read only space actually applies for physical memory (byte)',
  -- new large object space size
  `new_lo_space_size` BIGINT UNSIGNED COMMENT 'new large object space total (byte)',
  `new_lo_space_used` BIGINT UNSIGNED COMMENT 'new large object space used (byte)',
  `new_lo_space_available` BIGINT UNSIGNED COMMENT 'new large object space available (byte)',
  `new_lo_space_committed` BIGINT UNSIGNED COMMENT 'new large object space actually applies for physical memory (byte)',
  -- code large object space size
  `code_lo_space_size` BIGINT UNSIGNED COMMENT 'code large object space total (byte)',
  `code_lo_space_used` BIGINT UNSIGNED COMMENT 'code large object space used (byte)',
  `code_lo_space_available` BIGINT UNSIGNED COMMENT 'code large object space available (byte)',
  `code_lo_space_committed` BIGINT UNSIGNED COMMENT 'code large object space actually applies for physical memory (byte)',

  -- gc
  `total_gc_times` INT UNSIGNED COMMENT 'total count of gc',
  `total_gc_duration` INT UNSIGNED COMMENT 'total duration of gc',
  `total_scavange_duration` INT UNSIGNED COMMENT 'total scavange duration of gc',
  `total_marksweep_duration` INT UNSIGNED COMMENT 'total marksweep duration of gc',
  `total_incremental_marking_duration` INT UNSIGNED COMMENT 'total incremental marking duration of gc',
  `gc_time_during_last_record` INT UNSIGNED COMMENT 'duration of last gc',
  `scavange_duration_last_record` INT UNSIGNED COMMENT 'scavange duration of last gc',
  `marksweep_duration_last_record` INT UNSIGNED COMMENT 'marksweep duration of last gc',
  `incremental_marking_duration_last_record` INT UNSIGNED COMMENT 'incremental marking duration of last gc',

  -- uv handles
  `active_handles` INT UNSIGNED COMMENT 'active and reference Libuv handles',
  `active_file_handles` INT UNSIGNED COMMENT 'active file handles',
  `active_and_ref_file_handles` INT UNSIGNED COMMENT 'active and reference file handles',
  `active_tcp_handles` INT UNSIGNED COMMENT 'active tcp handles',
  `active_and_ref_tcp_handles` INT UNSIGNED COMMENT 'active and reference tcp handles',
  `active_udp_handles` INT UNSIGNED COMMENT 'active udp handles',
  `active_and_ref_udp_handles` INT UNSIGNED COMMENT 'active and reference udp handles',
  `active_timer_handles` INT UNSIGNED COMMENT 'active timer handles',
  `active_and_ref_timer_handles`  INT UNSIGNED COMMENT 'active and reference timer handles',

  -- http
  `response_codes` VARCHAR(1024) DEFAULT '' COMMENT 'responese codes and count',
  `live_http_request` INT UNSIGNED COMMENT 'live http requests in last 1 min',
  `http_response_close` INT UNSIGNED COMMENT 'http connections close in last 1 min',
  `http_response_sent` INT UNSIGNED COMMENT 'http responeses sent in last 1 min',
  `http_request_timeout` INT UNSIGNED COMMENT 'timeout http requests in last 1 min',
  `http_patch_timeout` INT UNSIGNED COMMENT 'http patch timeout (s)',
  `http_rt` DECIMAL(5,2) COMMENT 'http average response time (ms)',

  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'system modify timestamp',
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'system create timestamp',
  PRIMARY KEY (`id`),
  INDEX (`app`, `agent`, `pid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'process info table';

-- template: `osinfo_${MM-DD}`
CREATE TABLE IF NOT EXISTS `osinfo`(
  `id` INT UNSIGNED AUTO_INCREMENT COMMENT 'unique auto increment id',
  `app` INT NOT NULL COMMENT 'app id',
  `agent` VARCHAR(50) NOT NULL COMMENT 'agent name',
  `uptime` INT UNSIGNED NOT NULL COMMENT 'system uptime',
  `log_time` DATETIME NOT NULL COMMENT 'system log created time on agent',
  `position` TINYINT UNSIGNED NOT NULL COMMENT '0: from system_log, 1: from xprofiler_log',
  `version` VARCHAR(50) DEFAULT '' COMMENT 'xprofiler version',

  -- cpu
  `used_cpu` DECIMAL(5,2) COMMENT 'cpu usage (0-100%)',
  `cpu_count` INT UNSIGNED COMMENT 'cpu count',

  -- mem
  `total_memory` BIGINT UNSIGNED COMMENT 'os total memory (byte)',
  `free_memory` BIGINT UNSIGNED COMMENT 'os free memory (byte)',

  -- load
  `load1` DECIMAL(5,2) COMMENT 'os load in last 1 min',
  `load5` DECIMAL(5,2) COMMENT 'os load in last 5 min',
  `load15` DECIMAL(5,2) COMMENT 'os load in last 15 min',

  -- disks
  `disks` VARCHAR(1024) COMMENT 'monitored disks directory and usage (0-100%)',

  -- node count
  `node_count` INT UNSIGNED COMMENT 'node process count',

  -- gc
  `total_gc_times` INT UNSIGNED COMMENT 'total count of gc (all process)',
  `total_gc_duration` INT UNSIGNED COMMENT 'total duration of gc (all process)',
  `total_scavange_duration` INT UNSIGNED COMMENT 'total scavange duration of gc (all process)',
  `total_marksweep_duration` INT UNSIGNED COMMENT 'total marksweep duration of gc (all process)',
  `total_incremental_marking_duration` INT UNSIGNED COMMENT 'total incremental marking duration of gc (all process)',
  `gc_time_during_last_record` INT UNSIGNED COMMENT 'duration of last gc (all process)',
  `scavange_duration_last_record` INT UNSIGNED COMMENT 'scavange duration of last gc (all process)',
  `marksweep_duration_last_record` INT UNSIGNED COMMENT 'marksweep duration of last gc (all process)',
  `incremental_marking_duration_last_record` INT UNSIGNED COMMENT 'incremental marking duration of last gc (all process)',

  -- http
  `response_codes` VARCHAR(1024) DEFAULT '' COMMENT 'responese codes and count',
  `live_http_request` INT UNSIGNED COMMENT 'live http requests in last 1 min',
  `http_response_close` INT UNSIGNED COMMENT 'http connections close in last 1 min',
  `http_response_sent` INT UNSIGNED COMMENT 'http responeses sent in last 1 min',
  `http_request_timeout` INT UNSIGNED COMMENT 'timeout http requests in last 1 min',
  `http_patch_timeout` INT UNSIGNED COMMENT 'http patch timeout (s)',
  `http_rt` DECIMAL(5,2) COMMENT 'http average response time (ms)',

  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'system modify timestamp',
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'system create timestamp',
  PRIMARY KEY (`id`),
  INDEX (`app`, `agent`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'os info table';

-- template: `alarm_${MM-DD}`
CREATE TABLE IF NOT EXISTS `alarm`(
  `id` INT UNSIGNED AUTO_INCREMENT COMMENT 'unique auto increment id',
  `strategy` INT UNSIGNED NOT NULL COMMENT 'strategy id',
  `agent` VARCHAR(50) NOT NULL COMMENT 'agent name',
  `message` VARCHAR(250) NOT NULL COMMENT 'alerm message',
  `pid` INT DEFAULT NULL COMMENT 'process id',
  `gm_modified` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'system modify timestamp',
  `gm_create` DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'system create timestamp',
  PRIMARY KEY (`id`),
  INDEX (`strategy`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT 'alarm info table';
